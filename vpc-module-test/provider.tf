terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.84.0"
    }
  }

backend "s3" {
  bucket = "tf-remotestate-prod1"
  key    = "vpc-test"
  region = "us-east-1"
  dynamodb_table = "tf-remotestate-prod"
  
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}