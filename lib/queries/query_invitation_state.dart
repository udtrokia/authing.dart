part of authing;

final String getUserInvitationEnableQuery = r'''
query getUserInvitationEnable($client: String!) {
  queryInvitationState(client: $client) {
    client
    enablePhone
  }
}
''';
    
