const query = r'''
query getWebhookSettingOptions{
  getWebhookSettingOptions{
    webhookEvents{
      name
    }
    contentTypes{
      name
    }
  } 
}
''';
