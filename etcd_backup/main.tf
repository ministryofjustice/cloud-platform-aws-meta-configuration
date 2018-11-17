terraform {
  backend "s3" {
    bucket = "cloud-platform-aws-etcdbackup-terraform-state"
    region = "eu-west-1"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region  = "${var.aws_region}"
  version = ">= 1.44.0"
}
