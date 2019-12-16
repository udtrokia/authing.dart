const query = r'''
query getUserInvitationList($client: String!) {
  queryInvitation(client: $client) {
    client
    phone
  }
}   
''';
