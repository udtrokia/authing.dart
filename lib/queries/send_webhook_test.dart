part of authing;

final String sendWebhookTestQuery = r'''
mutation SendWebhookTest($id: String!) {
  SendWebhookTest(id: $id)
} 
''';
