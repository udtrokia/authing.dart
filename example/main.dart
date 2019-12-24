import 'package:authing/authing.dart';

main() async {
	Options opts = Options(
		userPoolId: '5df760579d0df45585a2b7b3',
		secret: 'dc1501dff92e6b36c67f51a6b6f4e17c',
	);
	
	/// init authing client
	Authing authing = Authing(opts);

  /// handle res
	var res = await authing.register(
		username: 'David Bowie',
		email: 'bowie@mars.uni',
		password: 'hallo-spaceboy',
	);
	
	res.hasErrors? print(res.errors): print(res.data);
}
