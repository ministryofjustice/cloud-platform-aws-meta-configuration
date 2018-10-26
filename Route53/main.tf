terraform {
backend "s3" {
  bucket = "route53-terraform"
  region = "eu-west-1"
  key    = "terraform.tfstate"
  }
}
provider "aws" {
  region = "${var.aws_region}"
  } 


