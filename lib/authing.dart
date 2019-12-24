library authing;

import 'dart:convert';
import 'dart:io';
import 'package:encrypt/encrypt.dart';
import 'package:graphql/client.dart';
import 'package:meta/meta.dart';
import 'package:pointycastle/asymmetric/api.dart';

part 'client.dart';
part 'queries/add_client_webhook.dart';
part 'queries/add_to_invitation.dart';
part 'queries/assign_user_to_role.dart';
part 'queries/change_password.dart';
part 'queries/check_login_status.dart';
part 'queries/client.dart';
part 'queries/client_roles.dart';
part 'queries/create_role.dart';
part 'queries/decode_jwt_token.dart';
part 'queries/delete_client_webhook.dart';
part 'queries/get_all_webhooks.dart';
part 'queries/get_client_when_sdk_init.dart';
part 'queries/get_webhook_log_detail.dart';
part 'queries/get_webhook_logs.dart';
part 'queries/get_webhook_setting_options.dart';
part 'queries/is_client_belong_to_user.dart';
part 'queries/login.dart';
part 'queries/query_invitation.dart';
part 'queries/query_invitation_state.dart';
part 'queries/query_mfa.dart';
part 'queries/query_permission_list.dart';
part 'queries/query_role_by_user_id.dart';
part 'queries/refresh_token.dart';
part 'queries/register.dart';
part 'queries/remove_from_invitation.dart';
part 'queries/remove_users.dart';
part 'queries/remove_user_clients.dart';
part 'queries/remove_user_from_group.dart';
part 'queries/send_reset_password_email.dart';
part 'queries/send_verify_email.dart';
part 'queries/send_webhook_test.dart';
part 'queries/unbind_email.dart';
part 'queries/update_role.dart';
part 'queries/update_user.dart';
part 'queries/update_user_client.dart';
part 'queries/users_in_group.dart';
part 'queries/user.dart';
part 'queries/users.dart';
part 'queries/user_clients.dart';
part 'queries/user_client_type.dart';
part 'queries/verify_reset_password_verify_code.dart';

/// The high-level wrapper
class Authing {
  Options opts;
  Client cli;
  Authing(Options opts) {
    assert(opts != null);
    opts = opts;
    cli = Client(opts: opts);
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
  Future<QueryResult> register({
      String username,
      String email,
      String password,
      String lastIP,
      bool forceLogin,
      String phone,
      String invitationCode,
      String browser,
      @required String registerInClient
  }) async {
    return await cli.r(QueryOptions(
        document: registerQuery,
        variables: <String, dynamic>{
          'username': username,
          'email': email,
          'password': Authing.encrypt(password),
          'lastIP': lastIP,
          'forceLogin': forceLogin,
          'registerInClient': cli.opts.userPoolId,
          'phone': phone,
          'invitationCode': invitationCode,
          'browser': browser
        }
    ));
  }

  Future<QueryResult> login({
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

  Future<QueryResult> decodeJwtToken({
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

  Future<QueryResult> refreshToken({
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
  Future<QueryResult> user({
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

  Future<QueryResult> users({
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

  Future<QueryResult> checkLoginStatus({
      String token
  }) async {
    return await cli.r(QueryOptions(
        document: checkLoginStatusQuery,
        variables: <String, dynamic> {
          'token': token
        }
    ));
  }

  Future<QueryResult> removeUsers({
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

  Future<QueryResult> updateUser({
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

  Future<QueryResult> sendResetPasswordEmail({
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

  Future<QueryResult> verifyResetPasswordVerifyCode({
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

  Future<QueryResult> sendVerifyEmail({
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

  Future<QueryResult> changePassword({
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

  Future<QueryResult> unbindEmail({
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

  Future<QueryResult> clientRoles({
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

  Future<QueryResult> queryRoleByUserId({
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

  Future<QueryResult> createRole({
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

  Future<QueryResult> updateRole({
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

  Future<QueryResult> assignUserToRole({
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

  Future<QueryResult> removeUserFromGroup({
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
  Future<QueryResult> usersInGroup({
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
  Future<QueryResult> userClients({
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

  Future<QueryResult> client({
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

  Future<QueryResult> userClientType() async {
    return await cli.r(QueryOptions(
        document: getUserClientTypeQuery,
    ));
  }

  Future<QueryResult> queryPermissionList() async {
    return await cli.r(QueryOptions(
        document: queryPermissionListQuery
    ));
  }

  Future<QueryResult> isClientBelongToUser({
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
