const query = r'''
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
