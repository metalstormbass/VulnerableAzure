#Provider for K8, used after built
provider "kubernetes" {
  load_config_file       = "false"
  host                   = azurerm_kubernetes_cluster.vuln_cluster.endpoint
  token                  = azurerm_kubernetes_cluster.vuln_cluster.kube_config.password
}


#Provision AKS cluster in Azure

resource "azurerm_kubernetes_cluster" "vuln_cluster" {
  name                = "${var.vulnvm-name}-kubecluster"
  location            = azurerm_resource_group.victim-network-rg.location
  resource_group_name = azurerm_resource_group.victim-network-rg.name
  dns_prefix          = "${var.vulnvm-name}-k8"

  default_node_pool {
    name       = "default"
    node_count = var.nodecount
    vm_size    = "Standard_D2_v2"
  }

 service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
  
  network_profile {
    network_plugin     = "azure"
    network_policy     = "calico"     # Options are calico or azure - only if network plugin is set to azure
    dns_service_ip     = "172.16.0.10" # Required when network plugin is set to azure, must be in the range of service_cidr and above 1
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "172.16.0.0/16" # Must not overlap any address from the VNEt
  }
}


#Perform Configuration on K8 cluster itself