# authing.dart

## What is Authing

[Authing](https://authing.cn/) is an IDaaS which is created by Ivy.

## Installation
Make sure you have a working dart environment. 

To install `authing.dart`, Add this to your `pubspec.yaml`:

```shell
dependencies:
  authing: ^0.1.0
```

Then install:

```shell
pub get
```

## Usage

```dart
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
		passowrd: 'hallo-spaceboy'
	);
	
	if (res.hasErrors) print(res.errors);
	print(res.data);
}
```


## Issues
+ [ ] usersInGroup 500

## TODO
+ [ ] 社会化登录
+ [ ] 注册白名单
+ [ ] MFA 多因素认证
+ [ ] WebHook API

---

[Style Guide](https://dart.dev/guides/language/effective-dart)

---
