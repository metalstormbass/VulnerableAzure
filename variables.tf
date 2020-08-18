##################### Azure Info ######################

# victim company name 
variable "victim_company" {
  type        = string
  description = "This is the main naming convention for objects within Azure"
  default="VulnAZEnv"
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
  default = "10.78.0.0/16"
}

# victim subnet cidr
variable "victim-network-subnet-cidr" {
  type        = string
  description = "Subnet"
  default = "10.78.0.0/24"
}

# victim vm private ip
variable "internal-private-ip" {
  type        = string
  description = "Victim Private IP"
  default = "10.78.10.10"
}

# blob private ip
variable "blob-internal-private-ip" {
  type        = string
  description = "Blob Private IP"
  default "10.78.10.20"
}

##################### Secure Access #####################

# Source IP - CHANGE THIS FOR SECURITY REASONS
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
  default = "2"
}

#Client ID from Azure (App Registration)
variable "client_id" {
  type        = string
  description = "Client ID from Azure for K8"
}

#Client Secret From Azure (App Registration)
variable "client_secret" {
  type        = string
  description = "Client secret from Azure for K8"
}