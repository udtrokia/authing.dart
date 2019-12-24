library authing;

import 'dart:io';
import 'dart:convert';
import 'package:graphql/client.dart';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

part 'client.dart';
part 'queries/register.dart';
part 'queries/login.dart';
part 'queries/decodeJwtToken.dart';
part 'queries/refreshToken.dart';
part 'queries/user.dart';
part 'queries/users.dart';
part 'queries/checkLoginStatus.dart';
part 'queries/removeUsers.dart';
part 'queries/updateUser.dart';
part 'queries/sendResetPasswordEmail.dart';
part 'queries/verifyResetPasswordVerifyCode.dart';
part 'queries/sendVerifyEmail.dart';
part 'queries/changePassword.dart';
part 'queries/unbindEmail.dart';
part 'queries/clientRoles.dart';
part 'queries/queryRoleByUserId.dart';
part 'queries/createRole.dart';
part 'queries/updateRole.dart';
part 'queries/assignUserToRole.dart';
part 'queries/removeUserFromGroup.dart';
part 'queries/usersInGroup.dart';
part 'queries/userClients.dart';
part 'queries/client.dart';
part 'queries/userClientType.dart';
part 'queries/queryPermissionList.dart';
part 'queries/isClientBelongToUser.dart';
part 'queries/removeUserClients.dart';

/// [Authing] methds
class Authing {
  Options opts;
  Client cli;
  Authing(Options opts) {
    this.opts = opts ?? Options();
    this.cli = Client(opts: this.opts);
  }

  static String encrypt(String s) {
    final RSAPublicKey publicKey = RSAKeyParser().parse(
      r'''-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC4xKeUgQ+Aoz7TLfAfs9+paePb
5KIofVthEopwrXFkp8OCeocaTHt9ICjTT2QeJh6cZaDaArfZ873GPUn00eOIZ7Ae
+TiA2BKHbCvloW3w5Lnqm70iSsUi5Fmu9/2+68GZRH9L7Mlh8cFksCicW2Y2W2uM
GKl64GDcIq3au+aqJQIDAQAB
-----END PUBLIC KEY-----'''
    );
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    return encrypter.encrypt(s).base64;
  }

  /// User Verify
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
    return await cli.r(QueryOptions(
        document: registerQuery,
        variables: <String, dynamic>{
          'username': username,
          'email': email,
          'password': Authing.encrypt(password),
          'lastIP': lastIP,
          'forceLogin': forceLogin,
          'registerInClient': registerInClient,
          'phone': phone,
          'invitationCode': invitationCode,
          'browser': browser
        }
    ));
  }

  login({
      String username,
      String email,
      String password,
      String lastIP,
      String registerInClient,
      String phone,
      String browser,
      String verifyCode
  }) async {
    return await cli.r(QueryOptions(
        document: loginQuery,
        variables: <String, dynamic>{
          'username': username,
          'email': email,
          'password': Authing.encrypt(password),
          'lastIP': lastIP,
          'registerInClient': registerInClient,
          'phone': phone,
          'browser': browser,
          'verifyCode': verifyCode
        }
    ));
  }

  decodeJwtToken({
      String token,
      String email,
      String id,
      String clientId,
      String unionid
  }) async {
    return await cli.r(QueryOptions(
        document: decodeJwtTokenQuery,
        variables: <String, dynamic>{
          'token': token,
          'email': email,
          'id': id,
          'clientId': clientId,
          'unionid': unionid
        }
    ));
  }

  refreshToken({
      String client,
      String user
  }) async {
    return await cli.r(QueryOptions(
        document: refreshTokenQuery,
        variables: <String, dynamic> {
          'user': user,
          'client': client
        }
    ));
  }

  /// User Manager
  user({
      String registerInClient,
      String id,
      String token,
      bool auth,
      int userLoginHistoryPage,
      int userLoginHistoryCount
  }) async {
    return await cli.r(QueryOptions(
        document: userQuery,
        variables: <String, dynamic> {
          'registerInClient': registerInClient,
          'id': id,
          'token': token,
          'auth': auth,
          'userLoginHistoryPage': userLoginHistoryPage,
          'userLoginHistoryCount': userLoginHistoryCount
        }
    ));
  }

  users({
      String registerInClient,
      int page,
      int count,
      bool populate,
  }) async {
    return await cli.r(QueryOptions(
        document: usersQuery,
        variables: <String, dynamic> {
          'registerInClient': registerInClient,
          'page': page,
          'count': count,
          'populate': populate
        }
    ));
  }

  checkLoginStatus({
      String token
  }) async {
    return await cli.r(QueryOptions(
        document: checkLoginStatusQuery,
        variables: <String, dynamic> {
          'token': token
        }
    ));
  }

  removeUsers({
      List<String> ids,
      String operator,
      String registerInClient
  }) async {
    return await cli.r(QueryOptions(
        document: removeUsersQuery,
        variables: <String, dynamic> {
          'ids': ids,
          'operator': operator,
          'registerInClient': registerInClient
        }
    ));
  }

  updateUser({
      String id,
      String email,
      String username,
      String photo,
      String nickname,
      String company,
      String password,
      String oldPassword,
      String registerInClient,
      String phone,
      String browser
  }) async {
    return await cli.r(QueryOptions(
        document: updateUserQuery,
        variables: <String, dynamic> {
          'id': id,
          'email': email,
          'username': username,
          'photo': photo,
          'nickname': nickname,
          'company': company,
          'password': Authing.encrypt(password),
          'oldPassword': oldPassword != null? Authing.encrypt(oldPassword): '',
          'registerInClient': registerInClient,
          'phone': phone,
          'browser': browser
        }
    ));
  }

  sendResetPasswordEmail({
      String email,
      String client,
  }) async {
    return await cli.r(QueryOptions(
        document: sendResetPasswordEmailQuery,
        variables: <String, dynamic> {
          'email': email,
          'client': client,
        }
    ));
  }

  verifyResetPasswordVerifyCode({
      String email,
      String client,
      String verifyCode,
  }) async {
    return await cli.r(QueryOptions(
        document: verifyResetPasswordVerifyCodeQuery,
        variables: <String, dynamic> {
          'email': email,
          'client': client,
          'verifyCode': verifyCode
        }
    ));
  }

  sendVerifyEmail({
      String email,
      String client,
      String token
  }) async {
    return await cli.r(QueryOptions(
        document: sendVerifyEmailQuery,
        variables: <String, dynamic> {
          'email': email,
          'client': client,
          'token': token
        }
    ));
  }

  changePassword({
      String email,
      String client,
      String password,
      String verifyCode,
  }) async {
    return await cli.r(QueryOptions(
        document: changePasswordQuery,
        variables: <String, dynamic> {
          'email': email,
          'client': client,
          'password': Authing.encrypt(password),
          'verifyCode': verifyCode
        }
    ));
  }

  unbindEmail({
      String user,
      String client
  }) async {
    return await cli.r(QueryOptions(
        document: unbindEmailQuery,
        variables: <String, dynamic> {
          'user': user,
          'client': client,
        }
    ));
  }

  clientRoles({
      String client,
      int count,
      int page
  }) async {
    return await cli.r(QueryOptions(
        document: clientRolesQuery,
        variables: <String, dynamic> {
          'client': client,
          'count': count,
          'page': page,
        }
    ));
  }

  queryRoleByUserId({
      String user,
      String client
  }) async {
    return await cli.r(QueryOptions(
        document: queryRoleByUserIdQuery,
        variables: <String, dynamic> {
          'client': client,
          'user': user,
        }
    ));
  }

  createRole({
      String name,
      String client,
      String desc
  }) async {
    return await cli.r(QueryOptions(
        document: createRoleQuery,
        variables: <String, dynamic> {
          'name': name,
          'client': client,
          'descriptions': desc
        }
    ));
  }

  updateRole({
      String id,
      String client,
      String name,
      String desc,
      String pms
  }) async {
    return await cli.r(QueryOptions(
        document: updateRoleQuery,
        variables: <String, dynamic> {
          '_id': id,
          'name': name,
          'client': client,
          'descriptions': desc,
          'permissions': pms
        }
    ));
  }

  assignUserToRole({
      String user,
      String client,
      String group
  }) async {
    return await cli.r(QueryOptions(
        document: assignUserToRoleQuery,
        variables: <String, dynamic> {
          'user': user,
          'client': client,
          'group': group
        }
    ));
  }

  removeUserFromGroup({
      String client,
      String group,
      String user
  }) async {
    return await cli.r(QueryOptions(
        document: removeUserFromGroupQuery,
        variables: <String, dynamic> {
          'user': user,
          'client': client,
          'group': group
        }
    ));
  }

  /// [ERROR]
  usersInGroup({
      String group,
      String page,
      String count,
  }) async {
    return await cli.r(QueryOptions(
        document: usersInGroupQuery,
        variables: <String, dynamic> {
          'page': page,
          'count': count,
          'group': group
        }
    ));
  }

  /// User Pool
  userClients({
      String userId,
      int count,
      int page,
      bool computeUsersCount
  }) async {
    return await cli.r(QueryOptions(
        document: userClientsQuery,
        variables: <String, dynamic> {
          'userId': userId,
          'page': page,
          'count': count,
          'computeUsersCount': computeUsersCount
        }
    ));
  }

  client({
      String id,
      String userId,
      bool fromAdmin
  }) async {
    return await cli.r(QueryOptions(
        document: clientQuery,
        variables: <String, dynamic> {
          'userId': userId,
          'id': id,
          'fromAdmin': fromAdmin
        }
    ));
  }

  userClientType() async {
    return await cli.r(QueryOptions(
        document: getUserClientTypeQuery,
    ));
  }

  queryPermissionList() async {
    return await cli.r(QueryOptions(
        document: queryPermissionListQuery
    ));
  }

  isClientBelongToUser({
      String userId,
      String clientId,
      String pmdesc
  }) async {
    return await cli.r(QueryOptions(
        document: isClientBelongToUserQuery,
        variables: <String, dynamic> {
          'userId': userId,
          'clientId': clientId,
          'permissionDescriptors': pmdesc
        }
    ));
  }

  // removeUserClients({
  //     List<String> ids
  // }) async {
  //   return await cli.r(QueryOptions(
  //       document: removeUserClientsQuery,
  //       variables: <String, dynamic> {
  //         'ids': ids
  //       }
  //   ));
  // }

  // updateUserClient({
  //     String id,
  //     String name,
  //     String userId,
  //     String desc,
  //     String allowedOrigins,
  //     String jwtExpired,
  //     String registerDisabled,
  //     String showWXMPQRCode,
  //     bool useMiniLogin,
  //     bool emailVerifiedDefault,
  //     String frequentRegisterCheck
  // }) async {}
}
