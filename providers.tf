terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.98.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5.3"
    }
  }
  required_version = ">= 1.0.0"
}
provider "aws" {}