import 'dart:convert';
import 'package:graphql/client.dart';

/// As [opts] in TokenManager.
class TmOptionsHost {
  final String users;
  final String oauth;
  const TmOptionsHost({
      this.users = 'https://users.authing.cn/graphql',
      this.oauth = 'https://oauth.authing.cn/graphql',
  });
}

class TmOptionsPreFlightUrl {
  final String users;
  final String oauth;
  const TmOptionsPreFlightUrl({
      this.users = 'https://users.authing.cn/system/status',
      this.oauth = 'https://oauth.authing.cn/system/status',
  });
}

class TmOptions {
  final int timeout;
  final bool useSelfWxapp;
  final bool enableFetchPhone;
  final bool preflight;
  final bool cdnPreflight;
  final String cdnPreflightUrl;
  final String accessToken;
  final String userPoolId;
  final String secret;
  final TmOptionsHost host;
  final TmOptionsPreFlightUrl preflightUrl;
  
  const TmOptions({
      this.timeout =  10000,
      this.useSelfWxapp =  false,
      this.enableFetchPhone =  false,
      this.preflight =  false,
      this.cdnPreflight =  false,
      this.host = const TmOptionsHost(),
      this.preflightUrl = const TmOptionsPreFlightUrl(),
      this.cdnPreflightUrl = 'https://usercontents.authing.cn',
      this.accessToken =  '',
      this.userPoolId =  '',
      this.secret = '',
  });
}

/// Manage token in GraphQL client.
enum TokenType {
  OwnerToken,
  UserToken,
}

class TokenManager {
  final TmOptions opts;
  GraphQLClient client;
  String oToken;
  String uToken;
  bool lock;

  TokenManager({
      this.oToken = '',
      this.uToken = '',
      this.lock = false,
      this.opts = const TmOptions(),
      this.client,
  });

  static get base => TokenManager(
    client: GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: TmOptionsHost().users),
    )
  );

  /// TODO: Error handler
  refreshToken() async {
    const String doc = r'''
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
    ''';

    QueryOptions options = QueryOptions(
      document: doc,
      variables: <String, dynamic>{
        'clientId': opts.userPoolId,
        'secret': opts.secret,
      }
    );

    var res = await client.query(options);
    if (res.hasErrors) {
      print(res.errors);
    };
    
    oToken = res.data;
  }
  
  Future<String> getToken(TokenType type) async {
    try {
      String payload = oToken.split(".")[1];
      Map info = jsonDecode(utf8.decode(base64.decode(payload)));
      DateTime(info['exp'] * 1000).isBefore(DateTime.now()) && await refreshToken();
    } catch(e) {
      await refreshToken();
    }
    
    return type == TokenType.OwnerToken? oToken: uToken;
  }
}


void main() async {
  TokenManager tm = TokenManager.base;
  var res = await tm.getToken(TokenType.OwnerToken);
}
