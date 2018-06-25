# Cloud Platform Aws Meta Configuration
Tools for configuration of the Cloud Platform AWS account

## Login to AWS

[WebOps team members click here to log in using their github
accounts.](https://moj-cloud-platform-aws.eu.auth0.com/samlp/kFdXX6zOFH94lH17Cots9Nop0j8UfdBn)

## Auth0

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
