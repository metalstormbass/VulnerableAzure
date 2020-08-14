# Output the public ip of the gateway

output "Vulnerable_VM_IP" {
    value = azurerm_public_ip.vulnpublicip.ip_address
}


output "Company_Name" {
    value = var.victim_company
}

output "k8_service_url" {
  value ="${kubernetes_service.vuln_k8_service.load_balancer_ingress}"
}

