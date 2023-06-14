terraform {
  required_providers {
    external = {
      source = "hashicorp/external"
    }
  
    aws = {
      source = "hashicorp/aws"
   }
  }
  cloud {
    organization = "" //Must be set in the cloud configuration or as an environment variable: TF_CLOUD_ORGANIZATION

    workspaces {
      name = "sandbox" 
    }
  }
}
provider "aws" {
  region = var.aws_region 
}
//Get current account number
data "aws_caller_identity" "current" {} 