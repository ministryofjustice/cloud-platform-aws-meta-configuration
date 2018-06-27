# Auth0 Saml Rules

Auth0 supports automatic GitHub management of rules. These are already
connect to the `moj-cloud-platform-aws` Auth0 tenant.

If you need to reconnect them for any reason:

1. Log in to Auth0
1. Go to 'Extensions'
1. Install GitHub Deployments if it isn't already installed
1. Go to 'Installed Extensions'
1. Click on the GitHub Deployments Settings icon
1. Set `GITHUB_REPOSITORY` to `ministryofjustice/cloud-platform-aws-meta-configuration`
1. Set branch to `master`
1. Click on main 'GitHub Deployments' link and sign in
1. Go to https://github.com/ministryofjustice/cloud-platform-aws-meta-configuration/settings/hooks/new
1. Copy the Payload URL, Content Type and Secret from the Auth0 window
   to the GitHub webhooks window and click 'Add Webhook'
1. In the Auth0 GitHub Integration window go to 'Deployments'
1. Click the Deploy button
1. Go to Auth0 -> Rules and make sure your rules have appeared.


