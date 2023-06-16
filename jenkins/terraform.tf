terraform {
  required_providers {
    http = {
      source = "hashicorp/http"
      version = "3.3.0"
    }
    aws = {
      source = "hashicorp/aws"
    }
    ansible = {
      source = "ansible/ansible"
      version = "1.1.0"

    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.1"
    }
 }
}
data "aws_caller_identity" "current" {} //Get current account number