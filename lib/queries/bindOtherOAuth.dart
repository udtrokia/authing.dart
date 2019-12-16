const query = r'''
mutation bindOtherOAuth(
  $user: String
  $client: String
  $type: String!
  $unionid: String!
  $userInfo: String!
) {
  bindOtherOAuth(
    user: $user
    client: $client
    type: $type
    unionid: $unionid
    userInfo: $userInfo
  ) {
    _id
  }
}
''';
