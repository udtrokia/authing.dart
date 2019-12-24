part of authing;

final String queryPermissionListQuery = r'''
query queryPermissionList {
  queryPermissionList {
    list {
      _id
      name
      affect
      description
    }
  }
}
''';
