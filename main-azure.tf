provider "azurerm" {
    version = "=2.0.0"
    features {}
    }
    
#Provider for K8, used after built
provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.host
  username               = azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.username
  password               = azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.cluster_ca_certificate)
}
