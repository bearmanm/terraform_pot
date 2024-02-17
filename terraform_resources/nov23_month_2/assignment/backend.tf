# BACKEND

provider "aws" {
  region                   = "eu-west-2"
  # shared_credentials_files = ["~/.aws/credentials"] # cred are passing via environment variables # not needed 
}

terraform {
  required_version = "> 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    region = "eu-west-2"
    profile = "uk-grpctb-concourse-role" # created a new role in prod using an existing user 'skyuk-deploy-concourse-user' 
    bucket = "prod-grpctb-state-269632189206-s3" # this is the prod account where the state file will get stored 
    key = "sky/grpctb/prod-videoipath-state" # sky/grpctb is the path and prod-videoipath-state will be the will name
  }
}