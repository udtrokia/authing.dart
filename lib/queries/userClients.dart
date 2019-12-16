const query = r'''
query getUserClients($userId: String!, $page: Int, $count: Int) {
  userClients(userId: $userId, page: $page, count: $count) {
    totalCount
    list {
      _id
      name
      descriptions
      jwtExpired
      createdAt
      isDeleted
      secret
      logo
      clientType {
        _id
        name
        description
        image
        example
      }
    }
  }
}
''';
