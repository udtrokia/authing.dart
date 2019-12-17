import 'dart:convert';
import 'package:graphql/client.dart';

/// [Options]: Authing sdk [Options].
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
  final String api;
  final String cdnPreflightUrl;
  final String userPoolId;
  final String secret;
  final Host host;
  final PreFlightUrl preflightUrl;
  
  Options({
      int timeout,
      bool useSelfWxapp,
      bool enableFetchPhone,
      bool preflight,
      bool cdnPreflight,
      String accessToken,
      String api,
      String cdnPreflightUrl,
      String secret,
      String userPoolId,
      Host host,
      PreFlightUrl preflightUrl,
  }) : this.timeout = timeout ?? 10000,
       this.useSelfWxapp = useSelfWxapp ?? false,
       this.enableFetchPhone = enableFetchPhone ?? false,
       this.preflight =  preflight ?? false,
       this.cdnPreflight = cdnPreflight ?? false,
       this.accessToken = accessToken ?? '',
       this.api = api ?? 'https://api.github.com/graphql',
       this.cdnPreflightUrl = cdnPreflightUrl ?? 'https://usercontents.authing.cn',
       this.secret = secret ?? 'dc1501dff92e6b36c67f51a6b6f4e17c',
       this.userPoolId = userPoolId ?? '5df760579d0df45585a2b7b3',
       this.host = host ?? Host(),
       this.preflightUrl = preflightUrl ?? PreFlightUrl();
}
