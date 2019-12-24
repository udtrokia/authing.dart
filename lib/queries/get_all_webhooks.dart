part of authing;

final String getAllWebhooksQuery = r'''
query getAllWebhooks($client: String!) {
  getAllWebhooks(client: $client) {
    _id
    url
    events {
      name
      label
    }
    contentType
    client
    secret
    enable
    isLastTimeSuccess
  }
}  
''';
