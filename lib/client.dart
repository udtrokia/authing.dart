part of authing;
// import 'package:authing/options.dart';

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

  void toOwner() => dev = true;
  void toUser() => dev = false;
  void toggleGrant() => dev = !dev;
  
  String get token => dev? oToken: uToken;
  set token(String value) => dev? oToken = value: uToken = value;
}


/// [Options]: Authing sdk Options.
class Host {
  final String users = 'https://users.authing.cn/graphql';
  final String oauth = 'https://oauth.authing.cn/graphql';
}

class PreFlightUrl {
  final String users = 'https://users.authing.cn/system/status';
  final String oauth = 'https://oauth.authing.cn/graphql';
}

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
      @required String secret,
      @required String userPoolId,
      int timeout,
      bool useSelfWxapp,
      bool enableFetchPhone,
      bool preflight,
      bool cdnPreflight,
      String accessToken,
      String cdnPreflightUrl,
      Host host,
      PreFlightUrl preflightUrl,
  });   
}


/// [GraphQL Client]: Authing GraphQL Client with token management.
class Client {
  Options opts;
  TokenManager tm;
  GraphQLClient _client;

  Client({ Options opts, TokenManager tm }) {
    this.opts = opts ?? Options();
    this.tm = tm ?? TokenManager();
    
    HttpLink _httpLink = HttpLink(uri: this.opts.host.users);
    AuthLink _authLink = AuthLink(getToken: _getToken);
    Link _link = _authLink.concat(_httpLink);

    this._client = GraphQLClient(
      cache: InMemoryCache(),
      link: _link,
    );
  }

  Future<dynamic> r(QueryOptions opts) async {
    return await _client.query(opts);
  }
  
  Future<String> _getToken() async {
    /// [client]: Use default client without authorization.
    GraphQLClient client = GraphQLClient(
      cache: InMemoryCache(),
      link: HttpLink(uri: opts.host.users),
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

      DateTime exp = DateTime.fromMillisecondsSinceEpoch(info['exp'] * 1000);
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
