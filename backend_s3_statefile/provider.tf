# connection  terraform to aws
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# connection to AWS
/* provider "aws" {
  region     = "ap-south-1"
} */
