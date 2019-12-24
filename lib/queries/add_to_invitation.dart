part of authing;

final String addInvitationUserQuery = r'''
mutation addInvitationUser($client: String!, $phone: String!) {
  addToInvitation(client: $client, phone: $phone) {
    client
    phone
  }
}
''';
