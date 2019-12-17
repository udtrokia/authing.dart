import 'dart:io';
import 'dart:convert';
import 'package:graphql/client.dart';
import 'package:authing/options.dart';

/// [TokenManager]: A structure to deal with developer/user conditions.
/// 1. ownerToken: Developers' token.
/// 2. userToken: Developers' users' token.
class TokenManager {
  bool dev;
  String oToken;
  String uToken;

  TokenManager({
      this.dev = true,
      this.oToken = '',
      this.uToken = '',
  });

  String get token => dev? oToken: uToken;
  set token(String value) => dev? oToken = value: uToken = value;
}


/// [CliOptions]: Options for Authing GraphQL Client.
class CliOptions {
  String api;
  String secret;
  String userPoolId;
  
  CliOptions({
      this.api = 'https://users.authing.cn/graphql',
      this.secret = 'dc1501dff92e6b36c67f51a6b6f4e17c',
      this.userPoolId = '5df760579d0df45585a2b7b3',
  });

  CliOptions.fromOptions(Options opts) {
    api = opts.host.users;
    secret = opts.secret;
    userPoolId = opts.userPoolId;
  }
}


/// [GraphQL Client]: Authing GraphQL Client with token management.
class Client {
  CliOptions opts;
  TokenManager tm;
  GraphQLClient _client;

  Client({ CliOptions opts, TokenManager tm }) {
    this.opts = opts ?? CliOptions();
    this.tm = tm ?? TokenManager();
    
    HttpLink _httpLink = HttpLink(uri: this.opts.api);
    AuthLink _authLink = AuthLink(getToken: _getToken);
    Link _link = _authLink.concat(_httpLink);

    this._client = GraphQLClient(
      cache: InMemoryCache(),
      link: _link,
    );
  }

  Future<String> _getToken() async {
    /// [client]: Use default client without authorization.
    GraphQLClient client = GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: opts.api),
    );
    
    QueryOptions options = QueryOptions(
      document: r'''
        query getClientWhenSdkInit(
          $secret: String
          $clientId: String
        ) {
          getClientWhenSdkInit(
            secret: $secret
            clientId: $clientId
          ) {
            accessToken
          }
        }
      ''',
      variables: <String, dynamic>{
        'clientId': opts.userPoolId,
        'secret': opts.secret,
      }
    );

    /// [res.data]: {getClientWhenSdkInit: {accessToken: ...}}
    var res = await client.query(options);
    if (res.hasErrors) print(res.errors);
    tm.token = res.data['getClientWhenSdkInit']['accessToken'];

    /// Test if token expired.
    try {
      String payload = tm.token.split(".")[1];
      Map info = jsonDecode(utf8.decode(base64.decode(base64.normalize(payload))));

      DateTime exp = DateTime(info['exp'] * 1000);
      DateTime now = DateTime.now();
      if (exp.isBefore(now)) {
        print('Token Expired: ${exp.toString()} < ${now.toString()}');
        return await _getToken();
      }
    } catch(e) {
      print('Error: $e');
      return await _getToken();
    }
        
    return tm.token;
  }

  
  /// Ping server
  Future<bool> ping() async {
    stdout.write('ping......');

    try {
      String _ = await _getToken();
      print('pong');
      return true;
    } catch(e) {
      print('peng');
      print('Error: $e');
      return false;
    }
  }
}


/// [Test]
/// void main() async {
///   var cli = Client();
///   await cli.ping();
/// }
