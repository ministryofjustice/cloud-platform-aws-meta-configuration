terraform {
  backend "s3" {
    bucket = "cloud-platform-cloudtrail-tf-state"
    region = "eu-west-1"
    key    = "terraform.tfstate"
  }
}

provider "aws" {
    region = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "cloud-platform-cloudtrail" {
  name                          = "cp-cloudtrail"
  s3_bucket_name                = "${aws_s3_bucket.cloudtrail-bucket.id}"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  tags {
        business-unit           = "${var.business-unit}"
        owner                   = "${var.team_name}"
        infrastructure-support  = "${var.infrastructure-support}"
    }
}
resource "aws_s3_bucket" "cloudtrail-bucket" {
  bucket        = "cloud-platform-cloudtrail-moj"
  force_destroy = false
  tags {
        business-unit           = "${var.business-unit}"
        owner                   = "${var.team_name}"
        infrastructure-support  = "${var.infrastructure-support}"
    }
  lifecycle_rule {
    id                                     = "logs-transition"
    prefix                                 = ""
    abort_incomplete_multipart_upload_days = 7
    enabled                                = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 60
      storage_class = "GLACIER"
    }

    expiration {
      days = 365
    }
  }
  
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::cloud-platform-cloudtrail-moj"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::cloud-platform-cloudtrail-moj/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}
