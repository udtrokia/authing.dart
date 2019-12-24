part of authing;

final String unbindEmailQuery = r'''
mutation unbindEmail($user: String, $client: String) {
  unbindEmail(user: $user, client: $client) {
    _id
    email
  }
}
''';
