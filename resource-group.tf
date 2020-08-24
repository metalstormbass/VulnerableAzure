# Create a resource group for victim network
resource "azurerm_resource_group" "victim-network-rg" {
  name     = "${var.victim_company}-rg"
  location = var.location
}