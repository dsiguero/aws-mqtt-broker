terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "aws-mqtt-broker-tfstate"
    key    = "dev/terraform.tfstate"
    region = "eu-west-1"
  }

  required_version = "~> 1.3"
}

provider "aws" {
  region = var.aws_region
}
