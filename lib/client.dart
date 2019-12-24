part of authing;

/// A structure to deal with developer/user conditions.
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

  void toOwner() => dev = true;
  void toUser() => dev = false;
  void toggleGrant() => dev = !dev;
  
  String get token => dev? oToken: uToken;
  set token(String value) => dev? oToken = value: uToken = value;
}

class Host {
  final String users = 'https://users.authing.cn/graphql';
  final String oauth = 'https://oauth.authing.cn/graphql';
}

class PreFlightUrl {
  final String users = 'https://users.authing.cn/system/status';
  final String oauth = 'https://oauth.authing.cn/graphql';
}

/// Authing sdk Options.
class Options {
  final int timeout;
  final bool useSelfWxapp;
  final bool enableFetchPhone;
  final bool preflight;
  final bool cdnPreflight;
  final String accessToken;
  final String cdnPreflightUrl;
  final String userPoolId;
  final String secret;
  final Host host;
  final PreFlightUrl preflightUrl;
  
  Options({
      @required this.secret,
      @required this.userPoolId,
      this.timeout = 1000,
      this.useSelfWxapp = false,
      this.enableFetchPhone = false,
      this.preflight = false,
      this.cdnPreflight = false,
      this.accessToken = '',
      this.cdnPreflightUrl = '',
      String host,
      String preflightUrl,
  }) : host = Host(),
       preflightUrl = PreFlightUrl();
}


/// Authing GraphQL Client with token manager.
class Client {
  Options opts;
  TokenManager tm;
  GraphQLClient _client;

  Client({@required this.opts, TokenManager tm}) {
    this.tm = tm ?? TokenManager();
    
    var httpLink = HttpLink(uri: opts.host.users);
    var authLink = AuthLink(getToken: getToken);
    var link = authLink.concat(httpLink);
    
    _client = GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );
  }

  Future<dynamic> r(QueryOptions opts) async {
    return await _client.query(opts);
  }
  
  Future<String> getToken() async {
    /// Use default client without authorization.
    var client = GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: opts.host.users),
    );
    
    var options = QueryOptions(
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

    /// res.data: {getClientWhenSdkInit: {accessToken: ...}}
    var res = await client.query(options);
    if (res.hasErrors) print(res.errors);
    tm.token = res.data['getClientWhenSdkInit']['accessToken'];

    /// Test if token expired.
    try {
      var payload = tm.token.split('.')[1];
      var info = jsonDecode(utf8.decode(base64.decode(base64.normalize(payload))));

      var exp = DateTime.fromMillisecondsSinceEpoch(info['exp'] * 1000);
      var now = DateTime.now();

      if (exp.isBefore(now)) {
        print('Token Expired: ${exp.toString()} < ${now.toString()}');
        return await getToken();
      }
    }

    on Exception catch(e) {
      print('Error: $e');
      return await getToken();
    }
        
    return tm.token;
  }

  
  /// Ping server
  Future<bool> ping() async {
    stdout.write('ping......');

    try {
      var _ = await getToken();
      print('pong');
      return true;
    }

    on Exception catch(e) {
      print('peng');
      print('Error: $e');
      return false;
    }
  }
}
