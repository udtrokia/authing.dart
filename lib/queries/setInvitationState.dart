const query = r'''
mutation setUserInvitationEnable($client: String!, $enablePhone: Boolean!) {
  setInvitationState(client: $client, enablePhone: $enablePhone) {
    client
    enablePhone
    createdAt
    updatedAt
  }
}
''';
