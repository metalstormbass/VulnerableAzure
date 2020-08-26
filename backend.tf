terraform {
  backend "remote" {
    organization = "BigZal"

    workspaces {
      name = "AzureVulnerable"
    }
  }
}
