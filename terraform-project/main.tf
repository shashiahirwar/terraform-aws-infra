provider "aws" {
  region = var.aws_region
}

module "production" {
  source     = "./environments/production"
  aws_region = "us-east-1"

  providers = {
    aws = aws
  }
}

module "development" {
  source     = "./environments/development"
  aws_region = "us-east-1"

  providers = {
    aws = aws
  }
}