################################Exposed Public Blob

resource "azurerm_storage_account" "victim-public-storage" {
  name                     = "victimpublicstorageacc"
  resource_group_name      = azurerm_resource_group.victim-network-rg.name
  location                 = azurerm_resource_group.victim-network-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "victim-public-container" {
  name                  = "test"
  storage_account_name  = azurerm_storage_account.victim-public-storage.name
  container_access_type = "container"
}

resource "azurerm_storage_blob" "victim-public-blob" {
  name                   = "test.zip"
  storage_account_name   = azurerm_storage_account.victim-public-storage.name
  storage_container_name = azurerm_storage_container.victim-public-container.name
  type                   = "Block"
  source                 = "files/personalinformation.zip"
}


#################################Backend Private Blob

resource "azurerm_storage_account" "victim-private-storage" {
  name                     = "victimprivatestorage"
  resource_group_name      = azurerm_resource_group.victim-network-rg.name
  location                 = azurerm_resource_group.victim-network-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  
   network_rules {
    default_action             = "allow"
    ip_rules                   = ["$var.internal-private-ip"]
    virtual_network_subnet_ids = ["azurerm_subnet.victim-network-subnet.id"]
  }


}

resource "azurerm_storage_container" "victim-private-container" {
  name                  = "${var.vulnvm-name}-backend"
  storage_account_name  = azurerm_storage_account.victim-private-storage.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "victim-private-blob" {
  name                   = "secrets.txt"
  storage_account_name   = azurerm_storage_account.victim-private-storage.name
  storage_container_name = azurerm_storage_container.victim-private-container.name
  type                   = "Block"
# source                 = "files/personalinformation.zip"

}