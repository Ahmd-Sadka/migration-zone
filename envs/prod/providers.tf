terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
     tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0"  # You can specify the version you need
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"  # You can specify the version you need
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"  # You can specify the version you need
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"  # You can specify the version you need
    }
  }

  required_version = ">= 1.7.0"
}

provider "aws" {
  region = var.aws_region
}