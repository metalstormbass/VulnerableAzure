#Vulnerable Public IP Address

resource "azurerm_public_ip" "vulnpublicip" {
    name                         = "${var.vulnvm-name}-public-ip"
    location                     = azurerm_resource_group.victim-network-rg.location
    resource_group_name          = azurerm_resource_group.victim-network-rg.name
    allocation_method = "Static"
}

