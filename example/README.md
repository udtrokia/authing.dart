<h1 align="center">
  <a href="https://authing.cn"><img width="550" src="https://cdn.authing.cn/authing-logo@2.png?a=1" alt="Authing" /></a>
</h1>

<h3 align="center">Authing —— 一个所有人可用的身份管理平台</h3>

## Authing 是什么？

[Authing](http://github.com/Authing/authing) 提供身份认证和授权服务，我们提供跨平台的 SDK（Android、iOS 和 Web），帮助开发者和企业使用六行代码拥有邮箱/密码、短信/验证码、扫码登录、社会化登录等功能。

当用户发起授权请求时，Authing 会帮助你认证他们的身份和返回必要的用户信息到你的应用中。

![https://github.com/Authing/authing/blob/master/imgs/authing.png?raw=true](https://github.com/Authing/authing/blob/master/imgs/authing.png?raw=true)

开发计划路线图：[Authing Roadmap](https://github.com/Authing/authing/projects/1)。


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

[Style Guide](https://dart.dev/guides/language/effective-dart)
