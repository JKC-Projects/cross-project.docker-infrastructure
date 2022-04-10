terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.8"
    }
  }

  # set TF CLI version
  required_version = "~> 1.1"

  # use Terraform Cloud as state backend
  cloud {
    organization = "shared-infrastructure"
    workspaces {
      name = "docker-infrastructure"
    }
  }
}

provider "aws" {
  region = "eu-west-1"

  default_tags {
    tags = {
      project    = "all_projects"
      managed_by = "terraform"
      github_org = "shared-infrastructure"
      repo       = "docker-infrastructure"
    }
  }
}

# Data block allows us to access the above default tags
# https://learn.hashicorp.com/tutorials/terraform/aws-default-tags?in=terraform/aws
data "aws_default_tags" "current" {}