const query = r'''
mutation SendWebhookTest($id: String!) {
  SendWebhookTest(id: $id)
} 
''';
