part of authing;

const queryPermissionListQuery = r'''
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
