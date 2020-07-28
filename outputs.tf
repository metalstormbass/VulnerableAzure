# Output the public ip of the gateway

output "Vulnerable_VM_IP" {
    value = azurerm_public_ip.vulnpublicip.ip_address
}


output "Company_Name(Could be useful for enumeration)" {
    value = azurerm_public_ip.vulnpublicip.ip_address
}

