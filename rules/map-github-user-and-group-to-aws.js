function (user, context, callback) {
    user.awsRole = 'arn:aws:iam::754256621582:role/github-webops,arn:aws:iam::754256621582:saml-provider/moj-cloud-platform-aws';
    user.awsRoleSession = user.nickname;

    context.samlConfiguration.mappings = {
          'https://aws.amazon.com/SAML/Attributes/Role': 'awsRole',
          'https://aws.amazon.com/SAML/Attributes/RoleSessionName': 'awsRoleSession'
        };

    callback(null, user, context);
}
