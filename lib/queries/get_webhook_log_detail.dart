part of authing;

final String getWebhookLogDetailQuery = r'''
query getWebhookLogDetail($id: String!) {
  getWebhookLogDetail(id: $id) {
    _id
    request {
      headers
      payload
    }
    response {
      headers
      body
      statusCode
    }
    errorMessage
    when
  }
}   
''';
