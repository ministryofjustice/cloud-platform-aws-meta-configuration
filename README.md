# Cloud Platform Aws Meta Configuration

[![CircleCI](https://circleci.com/gh/ministryofjustice/cloud-platform-aws-meta-configuration.svg?style=svg)](https://circleci.com/gh/ministryofjustice/cloud-platform-aws-meta-configuration)

Tools for configuration of the Cloud Platform AWS account

## Login to AWS

[WebOps team members click here to log in using their github
accounts.](https://moj-cloud-platform-aws.eu.auth0.com/samlp/kFdXX6zOFH94lH17Cots9Nop0j8UfdBn)

## Setup GitHub->AWS OAuth integration Terraform

Assumption: The Auth0 account described below is active.

This has already been configured at the time of writing.  It should not
be necessary to do it again.

### Quickstart

See [Rattic 1091](https://rattic.service.dsd.io/cred/detail/1091/) for
access details that allow you to get the necessary AWS keys.

```bash
cd aws_federation
terraform plan
terraform apply
```

### Auth0

**You should not require direct access to any of the Auth0 configration
for day-to-day usage of the AWS login.**

This integration uses [Auth0](https://auth0.com/) to connect GitHub
accounts to AWS via an Auth0 SAML2 add on. This add on is configured in
the Auth0 `Cloud Platform AWS Login` application on the
`moj-cloud-platform-aws` tenant in Auth0.

### SAML XML metadata config

Auth0 provides this as a standalone file to be added to the AWS IAM
configuration. If you need to re-upload, you can have an admin add your
GPG key here so you can decrypt this stored version.  You can also
download another copy directly from the Auto0 SAML2 add on once you have
logged in there.

## Testing

From the project root just run `./test.sh`.

This is exactly the same script CircleCI uses.

