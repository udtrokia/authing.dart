part of authing;

final String removeUserClientsQuery = r'''
mutation removeUserClients($ids: [String]) {
  removeUserClients(ids: $ids) {
    _id
  }
}  
''';
