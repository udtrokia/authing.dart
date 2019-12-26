import 'package:authing/authing.dart';

final String pool = '5e0489a3b6cbc91087ac82ae';
final String user = '5e048b98b6cbc957baac8c94';
final String role = '5e048ad3b6cbc953a0ac88f7';

main() async {
	Options opts = Options(
		userPoolId: '5e0489a3b6cbc91087ac82ae',
		secret: 'fd5ba7fa24036a33e9c85630c2e02b75',
	);
	
	/// init authing client
	Authing authing = Authing(opts);

  /// handle res
	var res = await authing.updateUserClient(
    // username: 'David Bowie',
    // password: '1118',
    // email: 'udtrokia@163.com',
    // registerInClient: pool,
    desc: 'hallo spaceboy',
    userId: user,
    id: pool,
	);
	
	if (res.hasErrors){
    print(res.errors);
  } else {
    print(res.data);
  }
}
