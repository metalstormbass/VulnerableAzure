################################Exposed Public Blob

resource "azurerm_storage_account" "victim-public-storage" {
  name                     = lower("${var.victim_company}test")
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




