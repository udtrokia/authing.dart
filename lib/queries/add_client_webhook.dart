part of authing;

final String addClientWebhookQuery = r'''
mutation addClientWebhook(
  $url: String!
  $events: [String!]!
  $client: String!
  $secret: String
  $contentType: String!
  $enable: Boolean!
) {
  addClientWebhook(
    url: $url
    events: $events
    client: $client
    secret: $secret
    enable: $enable
    contentType: $contentType
  ) {
    _id
  }
}    
''';
