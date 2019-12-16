const query = r'''
mutation SendResetPasswordEmail($email: String!, $client: String!) {
  sendResetPasswordEmail(email: $email, client: $client) {
    message
    code
  }
}
''';
    
