# backend refers to the storage and retrieval mechanism for Terraform state files. 
# it contains provider and terraform is used to define and provision infrastructure using Hashicorp Terraform

provider "aws" {
  region = "eu-west-2"
}

terraform {
  required_version = "> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.0"
    }
  }
  backend "s3" {
    region = "eu-west-2"
  }
}

locals {
  environment = "prod"
}