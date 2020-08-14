# Output the public ip of the gateway

output "Vulnerable_VM_IP" {
    value = azurerm_public_ip.vulnpublicip.ip_address
}


output "Company_Name" {
    value = var.victim_company
}

output "K8-fqdn" {
  value = azurerm_kubernetes_cluster.vuln_k8_cluster.fqdn
}
output "kube_config" {
  value = azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config_raw
}





output "client_key" {
    value = "${azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.client_key}"
}
 
output "client_certificate" {
    value = "${azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.client_certificate}"
}
 
output "cluster_ca_certificate" {
    value = "${azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.cluster_ca_certificate}"
}
 
output "cluster_username" {
    value = "${azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.username}"
}
 
output "cluster_password" {
    value = "${azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.password}"
}
 
 
output "host" {
    value = "${azurerm_kubernetes_cluster.vuln_k8_cluster.kube_config.0.host}"
}