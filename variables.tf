##################### Azure Info ######################

# victim company name 
variable "victim_company" {
  type        = string
  description = "This is the main naming convention for objects within Azure"
}

# azure region
variable "location" {
  type        = string
  description = "Azure region where the resources will be created"
  default     = "West US 2"
}


##################### Azure Networking #################
# victim vnet cidr
variable "victim-network-vnet-cidr" {
  type        = string
  description = "VNET"
}

# victim vnet cidr
variable "victim-network-subnet-cidr" {
  type        = string
  description = "Subnet"
}

# victim vm private ip
variable "internal-private-ip" {
  type        = string
  description = "Victim Private IP"
}

# blob private ip
variable "blob-internal-private-ip" {
  type        = string
  description = "Blob Private IP"
}

##################### Secure Access #####################

# Source IP - CHANGE THIS
variable "source-ip" {
  type        = string
  description = "Only IP Address to access Vulnerable Web App"
  default     = "0.0.0.0/0"
}


##################### Azure VM ##########################

# environment
variable "environment" {
  type        = string
  description = "Staging or Production"
  default     = "Staging"
}

# vulnvm-name
variable "vulnvm-name" {
  type        = string
  description = "Name of Vulnerable VM"
  default     = "AzureVulnVM"
}

# username
variable "username" {
  type        = string
  description = "Username"
}

# password
variable "password" {
  type        = string
  description = "Password"
}

################## K8 ##################################

#Nodes
variable "nodecount" {
  type        = string
  description = "Kubernetes Node Count"
}
