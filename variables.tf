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
