const query = r'''
mutation removeInvitationUser($client: String!, $phone: String!) {
  removeFromInvitation(client: $client, phone: $phone) {
    client
    phone
  }
}   
''';
