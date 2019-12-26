part of authing;

final String getUserByRoleQuery = r'''
query UserGroup($group: String!, $client: String!, $page: Int, $count: Int) {
  userGroup(client: $client, group: $group, page: $page, count: $count) {
    totalCount
    list {
      _id
      group {
        _id
      }
      client {
        _id
      }
      user {
        _id
        photo
        username
        email
      }
      createdAt
    }
  }
}
''';
