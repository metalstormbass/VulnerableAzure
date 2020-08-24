#This info is required for Github Actions to trigger the Terraform Cloud Deployment

terraform {
      backend "remote" {
         # The name of your Terraform Cloud organization.
         organization = var.organization_name

         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = var.workspace_name
         }
       }
     }
