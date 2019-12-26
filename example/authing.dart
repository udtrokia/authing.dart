import 'package:authing/authing.dart';

main() async {
	Options opts = Options(
		userPoolId: '...',
		secret: '...',
	);
	
	/// init authing client
	Authing authing = Authing(opts);

  /// handle res
	var res = await authing.register(
		username: 'David Bowie',
		email: 'bowie@mars.uni',
		password: 'hallo-spaceboy'
	);
	
	if (res.hasErrors) {
    print(res.errors);
  } else {
	  print(res.data);
  }
}
