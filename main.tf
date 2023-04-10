terraform {
 ## "required_providers" is used to define which providers we need ##
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.18.0"
    }
  }

# Use this for S3 as backend ##
  backend "s3" {
    bucket = "terraformstatefiles-prod-cts"
    key    = "tick-tac/terraform.tfstate"
    region = "us-east-1"
    profile = "prod-halopay"
  }
}

## This code block defines our provider. We are using AWS in this case. ##
provider "aws" {
  region  = "us-east-1"
  profile = "prod-halopay"
}