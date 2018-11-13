terraform {
  backend "s3" {
    bucket = "cloud-platform-intergration-etcdbackup-terraform-state"
    region = "eu-west-1"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
  region = "${var.aws_region}"
}
