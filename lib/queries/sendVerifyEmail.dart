const query = r'''
mutation SendVerifyEmail($email: String!, $client: String!) {
  sendVerifyEmail(email: $email, client: $client) {
    message
  }
}
''';
