part of authing;

final String getUserInvitationListQuery = r'''
query getUserInvitationList($client: String!) {
  queryInvitation(client: $client) {
    client
    phone
  }
}   
''';
