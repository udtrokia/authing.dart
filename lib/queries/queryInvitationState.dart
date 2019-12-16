const query = r'''
query getUserInvitationEnable($client: String!) {
  queryInvitationState(client: $client) {
    client
    enablePhone
  }
}
''';
    
