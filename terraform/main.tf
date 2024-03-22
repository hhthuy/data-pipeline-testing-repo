terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }

  backend "s3" {
    bucket = "thuy-s3bucket-aws"
    key    = "terraform/tf.state"
    region = "us-east-1"
  }
}

provider "aws" {}