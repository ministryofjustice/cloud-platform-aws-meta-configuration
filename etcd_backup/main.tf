terraform {
  backend "s3" {
    bucket = "cloud-platform-<aws_account>-etcdbackup-terraform-state"
    region = "eu-west-1"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region = "${var.aws_region}"
}
