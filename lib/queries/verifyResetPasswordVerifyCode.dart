part of authing;

const verifyResetPasswordVerifyCodeQuery = r'''
mutation VerifyResetPasswordVerifyCode(
  $email: String!
  $client: String!
  $verifyCode: String!
) {
  verifyResetPasswordVerifyCode(
    email: $email
    client: $client
    verifyCode: $verifyCode
  ) {
    message
    code
  }
}
''';
