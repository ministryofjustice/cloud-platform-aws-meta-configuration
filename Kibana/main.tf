terraform {
  backend "s3" {
    bucket = "cloud-platform-kibana"
    region = "eu-west-1"
    key    = "terraform.tfstate"
  }
}

data "terraform_remote_state" "global" {
  backend = "s3"

  config {
    bucket = "cloud-platform-kibana"
    region = "eu-west-1"
    key    = "terraform.tfstate"
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "test" {
  domain_name           = "${var.test_domain}"
  elasticsearch_version = "6.2"

  cluster_config {
    instance_type = "t2.small.elasticsearch"
    instance_count = "3"
  }

  ebs_options {
    ebs_enabled = "true"
    volume_type = "gp2"
    volume_size = "32"
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.test_domain}/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": ${jsonencode(keys(var.allowed_test_ips))}
        }
      }
    }
  ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags {
    Domain = "${var.test_domain}"
  }
}

resource "aws_elasticsearch_domain" "live" {
  domain_name           = "${var.live_domain}"
  elasticsearch_version = "6.2"

  cluster_config {
    instance_type = "m4.large.elasticsearch"
    instance_count = "3"
  }

  ebs_options {
    ebs_enabled = "true"
    volume_type = "gp2"
    volume_size = "320"
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.live_domain}/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": ${jsonencode(keys(var.allowed_live_ips))}
        }
      }
    }
  ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags {
    Domain = "${var.live_domain}"
  }
}

resource "aws_elasticsearch_domain" "audit" {
  domain_name           = "${var.audit_domain}"
  elasticsearch_version = "6.2"

  cluster_config {
    instance_type = "m4.large.elasticsearch"
    instance_count = "2"
  }

  ebs_options {
    ebs_enabled = "true"
    volume_type = "gp2"
    volume_size = "320"
  }

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "es:*",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.audit_domain}/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": ${jsonencode(keys(var.allowed_audit_ips))}
        }
      }
    }
  ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags {
    Domain = "${var.audit_domain}"
  }
}
