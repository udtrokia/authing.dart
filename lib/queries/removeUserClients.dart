part of authing;

const removeUserClientsQuery = r'''
mutation removeUserClients($ids: [String]) {
  removeUserClients(ids: $ids) {
    _id
  }
}  
''';
