library authing;
import 'dart:convert';
import 'package:oauth2/oauth2.dart';
import 'package:graphql/client.dart';
import 'package:encrypt/encrypt.dart';
import 'package:http/http.dart' as http;

const String userEndpointDevURL  = "http://users.authing.dodora.cn/graphql";
const String oauthEndpointDevURL = "http://oauth.authing.dodora.cn/graphql";
const String userEndpointProdURL  = "https://users.authing.cn/graphql";
const String oauthEndpointProdURL = "https://oauth.authing.cn/graphql";
const String pubPEM = r'''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4xKeUgQ+Aoz7TLfAfs9+paePb
5KIofVthEopwrXFkp8OCeocaTHt9ICjTT2QeJh6cZaDaArfZ873GPUn00eOIZ7Ae
+TiA2BKHbCvloW3w5Lnqm70iSsUi5Fmu9/2+68GZRH9L7Mlh8cFksCicW2Y2W2uM
GKl64GDcIq3au+aqJQIDAQAB
-----END PUBLIC KEY-----''';

class Client {
  final GraphQLClient client;
  final String clientID;
  final void Function(String s) log;

  Client({ this.client, this.clientID, this.log});
}

Client newClient(String clientID, String appSecret, bool isDev) {
  String endpointURL = isDev? userEndpointDevURL: userEndpointProdURL;
  String accessToken = 'imtoken'; // getAccessTokenByAppSecret(client, clientID, appSecret);

  /// TODO:
  /// + merge oauth2 client and graphQL client
  http.Client httpClient = await oauth2.clientCredentialsGrant(
    endpointURL, clientID, accessToken
  );

  GraphQLClient client = GraphQLClient(
    cache: InMemoryCache(),
    link: endpointURL,
  );
  
  return Client(client: client, clientID: clientID);
}
