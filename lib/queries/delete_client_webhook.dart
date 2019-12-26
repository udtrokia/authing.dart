part of authing;

final String deleteClientWebhookQuery = r'''
mutation deleteClientWebhook($id: String!) {
  deleteClientWebhook(id: $id) {
    _id
  }
}
''';
