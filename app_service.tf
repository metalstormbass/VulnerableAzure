#Create App Service Plan
resource "azurerm_app_service_plan" "vulnerablewebapp_serviceplan" {
  name                = "${var.victim_company}-app"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name
  kind = "Linux"
  reserved = true
  sku {
    tier = "Standard"
    size = "S1"
  }
}

#Create App Service
resource "azurerm_app_service" "vulnerablewebapp_appservice" {
  name                = "${var.victim_company}-app-service"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name
  app_service_plan_id = azurerm_app_service_plan.vulnerablewebapp_serviceplan.id

 site_config {
    linux_fx_version = "PYTHON|3.7"
    use_32_bit_worker_process = false
  }
}
