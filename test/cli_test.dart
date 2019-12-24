import 'dart:io';
import 'package:authing/authing.dart';


main() async {
  var a = Authing();
  var res = await a.register(
    username: 'mercury',
    email: 'udtrokia@163.com',
    password: 'aaa',
    registerInClient: a.cli.opts.userPoolId
  );
  
  print(res.hasErrors);
  if (res.hasErrors) print(res.errors);
  print(res.data);
}
