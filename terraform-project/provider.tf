# terraform block — for versioning and provider requirements
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.5.0"
    }
  }
}

# provider block — for configuring credentials and region
/* provider "aws" {
  region     = var.aws_region
} */
# terraform {
#   cloud {
#     organization = "tf-cloudops"

#     workspaces {
#       name = "TF"
#     }
#   }
# }
