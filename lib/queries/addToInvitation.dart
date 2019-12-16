const query = r'''
mutation addInvitationUser($client: String!, $phone: String!) {
  addToInvitation(client: $client, phone: $phone) {
    client
    phone
  }
}
''';
