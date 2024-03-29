# Configuration for Terraform
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
  # Remote State Storage
  backend "s3" {
    bucket = "thuy-s3bucket-terraform-maunal" #Name of the S3 bucket (manually created in your AWS account beforehand)
    key    = "terraform/tf.state"             #Path within the bucket to store the state file
    region = "us-east-1"                      
  }
}

provider "aws" {}