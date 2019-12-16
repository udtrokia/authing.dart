const query = r'''
mutation unbindOtherOAuth($user: String, $client: String, $type: String!) {
  unbindOtherOAuth(user: $user, client: $client, type: $type) {
    _id
    type
  }
}  
''';
