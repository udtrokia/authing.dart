const query = r'''
query getWebhookLogs($webhook: String!) {
  getWebhookLogs(webhook: $webhook) {
    _id
    event
    response {
      statusCode
    }
    errorMessage
    when
  }
} 
''';
