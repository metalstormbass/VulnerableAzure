#Exposed Public Blob

resource "azurerm_storage_account" "victim-public-storage" {
  name                     = "${var.victim_company}-storage"
  resource_group_name      = azurerm_resource_group.victim-network-rg.name
  location                 = azurerm_resource_group.victim-network-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "victim-public-container" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.victim-public-storage.name
  container_access_type = "public"
}

resource "azurerm_storage_blob" "victim-public-blob" {
  name                   = "${var.victim_company}""
  storage_account_name   = azurerm_storage_account.victim-public-storage.name
  storage_container_name = azurerm_storage_container.victim-public-container.name
  type                   = "Block"
  source                 = "personalinformation.zip"
}