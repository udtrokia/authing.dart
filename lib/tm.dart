import 'dart:convert';
import 'package:graphql/client.dart';

/// As [opts] in TokenManager.
class TmOptionsHost {
  final String users = 'https://users.authing.cn/graphql';
  final String oauth = 'https://oauth.authing.cn/graphql';
}

class TmOptionsPreFlightUrl {
  final String users = 'https://users.authing.cn/system/status';
  final String oauth = 'https://oauth.authing.cn/graphql';
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
  
  TmOptions({
      int timeout,
      bool useSelfWxapp,
      bool enableFetchPhone,
      bool preflight,
      bool cdnPreflight,
      String cdnPreflightUrl,
      String accessToken,
      String userPoolId,
      String secret,
      TmOptionsHost host,
      TmOptionsPreFlightUrl preflightUrl,
  }) : this.timeout = timeout ?? 10000,
       this.useSelfWxapp = useSelfWxapp ?? false,
       this.enableFetchPhone = enableFetchPhone ?? false,
       this.preflight =  preflight ?? false,
       this.cdnPreflight = cdnPreflight ?? false,
       this.cdnPreflightUrl = cdnPreflightUrl ?? 'https://usercontents.authing.cn',
       this.accessToken = accessToken ?? '',
       this.userPoolId = userPoolId ?? '5df760579d0df45585a2b7b3',
       this.secret = secret ?? 'dc1501dff92e6b36c67f51a6b6f4e17c',
       this.host = host ?? TmOptionsHost(),
       this.preflightUrl = preflightUrl ?? TmOptionsPreFlightUrl();
}

/// Manage token in GraphQL client.
enum TokenType {
  OwnerToken,
  UserToken,
}

class TokenManager {
  TmOptions opts;
  GraphQLClient client;
  String oToken;
  String uToken;
  bool lock;

  TokenManager({
      TmOptions opts,
      GraphQLClient client,
      String oToken,
      String uToken,
      bool lock,
  }) : this.oToken = '',
       this.uToken = '',
       this.lock = false,
       this.opts = TmOptions(),
       this.client = GraphQLClient(
         cache: InMemoryCache(),
         link: HttpLink(uri: TmOptionsHost().users),
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

    /// [res.data]: {getClientWhenSdkInit: {accessToken: ...}}
    oToken = res.data['getClientWhenSdkInit']['accessToken'];
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


/// [Test]
/// void main() async {
///   TokenManager tm = TokenManager();
///   var tk = await tm.getToken(TokenType.OwnerToken);
///   print(tk);
/// }
