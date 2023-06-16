terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
      version = "3.3.0"
    }
    ansible = {
      source = "ansible/ansible"
    }
    aws = {
      source = "hashicorp/aws"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
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
  region  = var.aws_region 
  profile = var.aws_profile
}
//Get current account number
data "aws_caller_identity" "current" {} 