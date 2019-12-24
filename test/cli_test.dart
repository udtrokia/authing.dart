import 'dart:io';
import 'package:authing/authing.dart';

const email = 'udtrokia@163.com';
const id = '5e0203276c3f11f16f49c545';
const token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImVtYWlsIjoidWR0cm9raWFAMTYzLmNvbSIsImlkIjoiNWUwMjAzMjc2YzNmMTFmMTZmNDljNTQ1IiwiY2xpZW50SWQiOiI1ZGY3NjA1NzlkMGRmNDU1ODVhMmI3YjMifSwiaWF0IjoxNTc3MTkwMjA1LCJleHAiOjE1Nzg0ODYyMDV9.2zClWaKyU8wn86dZs9x7IMRSfvEe1XAvJeYRkt24koI';
const role = '5e0222e86c3f117ae74a682d';

main() async {
  var a = Authing();
  // var res = await a.sendResetPasswordEmail(
  //   client: a.cli.opts.userPoolId,
  //   email: email
  // );
  
  var res = await a.usersInGroup(
    // name: 'Lou Reed',
    // user: id,
    // email: 'udtrokia@163.com',
    // password: '961118',
    // password: 'xor1118',
    // username: 'Mercury',
    // token: token,
    // id: role,
    // pms: '',
    // client: a.cli.opts.userPoolId,
    group: role,
    // desc: 'bitmaster',
    // registerInClient: a.cli.opts.userPoolId,
    // phone: '18626153029',
    // verifyCode: '5621',
    // auth: true,
  );
  
  if (res.hasErrors) print(res.errors);
  print(res.data);
}
