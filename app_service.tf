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

 lifecycle {
        ignore_changes = [
            site_config.0.scm_type
        ]
}
 site_config {
    linux_fx_version = "PYTHON|3.7"
    use_32_bit_worker_process = false
  }
}

#Provision the web app (https://github.com/terraform-providers/terraform-provider-azurerm/issues/1104)
resource "null_resource" "scm_integration" {
  provisioner "local-exec" {
    command     = "powershell/enable_scm.ps1 -webAppName ${azurerm_app_service.vulnerablewebapp_appservice.name} -appResourceGroupName ${azurerm_resource_group.victim-network-rg.name} -scmBranch master -repoUrl https://github.com/metalstormbass/VulnerableWebApp.git"
    interpreter = ["pwsh", "-Command"]
  }
}
