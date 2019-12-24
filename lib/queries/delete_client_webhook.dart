part of authing;

final String deleteClientWebhook = r'''
mutation deleteClientWebhook($id: String!) {
  deleteClientWebhook(id: $id) {
    _id
  }
}
''';
