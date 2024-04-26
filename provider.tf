terraform {
  required_version = "~> 1.8.1"  //Terraform version
  
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.45.0"   //Terraform aws provider version
    }
  }
}

provider "aws" {
  region                   = var.aws_region
  shared_credentials_files = var.my_credentials
  profile                  = var.my_profile
}
