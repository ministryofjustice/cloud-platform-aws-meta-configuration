// Allows users to log in to AWS with their Github identity
// Taken from: https://auth0.com/docs/integrations/aws/sso

function (user, context, callback) {
  var request = require('request');

  if(context.connection === 'github'){
    var github_identity = _.find(user.identities, { connection: 'github' });

    var teams_req = {
      url: 'https://api.github.com/user/teams',
      headers: {
        'Authorization': 'token ' + github_identity.access_token,
        'User-Agent': 'request'
      }
    };

    request(teams_req, function (err, resp, body) {
      if (resp.statusCode !== 200) {
        return callback(new Error('Error retrieving teams from github: ' + body || err));
      }

      // This can be found in the AWS Console -> Providers -> <Specific Provider> -> Provider ARN
      var idp_arn = "arn:aws:iam::754256621582:saml-provider/moj-cloud-platform-aws";
      // This can be found in the AWS Console -> Roles -> <Specific Role> -> *Base* of Role ARN
      var role_base_arn = "arn:aws:iam::754256621582:role/";

      // For now, this is the only role available.
      user.awsRole = ["github-webobs"];
      user.awsRoleSession = user.nickname;

      // Map the user's AWS roles and session name to the equivalent SAML attributes
      context.samlConfiguration.mappings = {
        'https://aws.amazon.com/SAML/Attributes/Role': 'awsRole',
        'https://aws.amazon.com/SAML/Attributes/RoleSessionName': 'awsRoleSession'
      };

      return callback(null, user, context);
    });

  } else {
    return callback(null, user, context);
  }
}
