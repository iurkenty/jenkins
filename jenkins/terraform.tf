// http provider to retrive my public ip
terraform {
  required_providers {
    http = {
      source = "hashicorp/external"
    }
  
    aws = {
      source = "hashicorp/aws"
   }
 }
}

provider "aws" {
  region = "us-west-2"
}

data "aws_caller_identity" "current" {} //Get current account number