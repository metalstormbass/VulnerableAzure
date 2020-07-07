# Create Security Group to access web

resource "azurerm_network_security_group" "victim-linux-nsg" {
  depends_on=[azurerm_resource_group.victim-network-rg]
  name = "vuln-web-linux-vm-nsg"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name
  security_rule {
    name                       = "allow-ssh"
    description                = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.source-ip
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-http"
    description                = "allow-http"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = var.source-ip
    destination_address_prefix = "*"
  }
  tags = {
    environment = var.environment
  }
}