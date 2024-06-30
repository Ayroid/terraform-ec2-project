terraform {
  backend "s3" {
    bucket = "tf-nana-bucket"
    key    = "tf-nana/terraform.tfstate"
    region = var.aws_region
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}
