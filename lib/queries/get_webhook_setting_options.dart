part of authing;

final String getWebhookSettingOptionsQuery = r'''
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
