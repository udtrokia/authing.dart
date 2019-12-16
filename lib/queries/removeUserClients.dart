const query = r'''
mutation removeUserClients($ids: [String]) {
  removeUserClients(ids: $ids) {
    _id
  }
}  
''';
