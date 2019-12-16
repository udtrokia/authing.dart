const query = r'''
mutation deleteClientWebhook($id: String!) {
  deleteClientWebhook(id: $id) {
    _id
  }
}
''';
