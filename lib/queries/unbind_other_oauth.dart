part of authing;

final String unbindOtherOAuthQuery = r'''
mutation unbindOtherOAuth($user: String, $client: String, $type: String!) {
  unbindOtherOAuth(user: $user, client: $client, type: $type) {
    _id
    type
  }
}  
''';
