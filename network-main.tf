# Create a resource group for victim network
resource "azurerm_resource_group" "victim-network-rg" {
  name     = "${var.victim_company}-rg"
  location = var.location
  tags = {
    application = var.victim_company
    environment = var.environment
  }
}

# Create the victim network VNET
resource "azurerm_virtual_network" "victim-network-vnet" {
  name                = "${var.victim_company}-vnet"
  address_space       = [var.victim-network-vnet-cidr]
  resource_group_name = azurerm_resource_group.victim-network-rg.name
  location            = azurerm_resource_group.victim-network-rg.location
  tags = {
    application = var.victim_company
    environment = var.environment
  }
}

# Create a victim subnet for Network
resource "azurerm_subnet" "victim-network-subnet" {
  name                 = "${var.victim_company}-subnet"
  address_prefix       = var.victim-network-subnet-cidr
  virtual_network_name = azurerm_virtual_network.victim-network-vnet.name
  resource_group_name  = azurerm_resource_group.victim-network-rg.name
}
