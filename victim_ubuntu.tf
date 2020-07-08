#Variable Processing
# Setup the userdata that will be used for the instance
data "template_file" "userdata_setup" {
  template = "${file("userdata_setup.template")}"

  vars  = {
    name       = "${var.username}"
    logic = "${file("vuln_bootstrap.sh")}"
  }
}



#Create Network Interface
resource "azurerm_network_interface" "vuln-ubuntu" {
  name                = "${var.vulnvm-name}-nic"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name

  ip_configuration {
    name                          = "${var.vulnvm-name}-ip"
    subnet_id                     = azurerm_subnet.victim-network-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address = var.internal-private-ip
    primary = true
        public_ip_address_id = azurerm_public_ip.vulnpublicip.id
  }
}

#Associate Security Group with Interface

resource "azurerm_network_interface_security_group_association" "victim-linux-nsg-int" {
  network_interface_id      = azurerm_network_interface.vuln-ubuntu.id
  network_security_group_id = azurerm_network_security_group.victim-linux-nsg.id
  }


resource "azurerm_virtual_machine" "main" {
  name                  = var.vulnvm-name
  location              = azurerm_resource_group.victim-network-rg.location
  resource_group_name   = azurerm_resource_group.victim-network-rg.name
  network_interface_ids = [azurerm_network_interface.vuln-ubuntu.id]
  depends_on = [
    azurerm_network_interface_security_group_association.victim-linux-nsg-int
  ]
  
  vm_size               = "Standard_DS1_v2"

  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.vulnvm-name}-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.vulnvm-name
    admin_username = var.username
    admin_password = var.password
    custom_data = data.template_file.userdata_setup.rendered
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = var.environment
  }
}

