library authing;

import 'dart:io';
import 'dart:convert';
import 'package:graphql/client.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

part 'client.dart';
part 'queries/register.dart';

/// [Authing] methds
class Authing {
  Client cli;
  Authing({Client cli}) {
    this.cli = cli ?? Client();
  }

  register({
      String username,
      String email,
      String password,
      String lastIP,
      bool forceLogin,
      String registerInClient,
      String phone,
      String invitationCode,
      String browser
  }) async {
    final RSAPublicKey publicKey = RSAKeyParser().parse(
      r'''-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4xKeUgQ+Aoz7TLfAfs9+paePb
5KIofVthEopwrXFkp8OCeocaTHt9ICjTT2QeJh6cZaDaArfZ873GPUn00eOIZ7Ae
+TiA2BKHbCvloW3w5Lnqm70iSsUi5Fmu9/2+68GZRH9L7Mlh8cFksCicW2Y2W2uM
GKl64GDcIq3au+aqJQIDAQAB
-----END PUBLIC KEY-----'''
    );
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    
    return await cli.r(QueryOptions(
        document: registerQuery,
        variables: <String, dynamic>{
          'username': username,
          'email': email,
          'password': encrypter.encrypt(password).base64,
          'lastIP': lastIP,
          'forceLogin': forceLogin,
          'registerInClient': registerInClient,
          'phone': phone,
          'invitationCode': invitationCode,
          'browser': browser
        }
    ));
  }
}
