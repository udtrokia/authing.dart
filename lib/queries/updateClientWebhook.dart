const query = r'''
mutation updateClientWebhook(
  $id: String!
  $url: String!
  $events: [String!]!
  $secret: String
  $enable: Boolean!
  $contentType: String!
) {
  updateClientWebhook(
    id: $id
    url: $url
    events: $events
    secret: $secret
    enable: $enable
    contentType: $contentType
  ) {
    _id
  }
}
''';
