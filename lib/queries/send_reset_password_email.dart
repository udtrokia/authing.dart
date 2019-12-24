part of authing;

final String sendResetPasswordEmailQuery = r'''
mutation SendResetPasswordEmail($email: String!, $client: String!) {
  sendResetPasswordEmail(email: $email, client: $client) {
    message
    code
  }
}   
''';
