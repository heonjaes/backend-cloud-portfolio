terraform {
  backend "s3" {
    bucket = "heonjae-resume-tfstate"
    region = "ap-southeast-2"                   
    key    = "terraform.tfstate"
    encrypt = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = var.aws_region
}