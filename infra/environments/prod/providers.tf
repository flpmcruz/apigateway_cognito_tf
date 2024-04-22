terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4.2"
    }
  }

  backend "s3" {
    bucket         = "prod-terraformstatebucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "prod-terraformstatelock"
  }
}

provider "aws" {
  region = var.aws_region
}