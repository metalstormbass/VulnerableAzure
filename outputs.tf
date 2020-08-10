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