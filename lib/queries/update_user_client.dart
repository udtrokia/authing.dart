part of authing;

final String updateUserClientQuery = r'''
mutation updateUserClient(
  $_id: String!
  $name: String
  $userId: String!
  $descriptions: String
  $allowedOrigins: String
  $jwtExpired: Int
  $registerDisabled: Boolean
  $showWXMPQRCode: Boolean
  $useMiniLogin: Boolean
  $emailVerifiedDefault: Boolean
  $frequentRegisterCheck: FrequentRegisterCheckConfigInput
  $loginFailCheck: LoginFailCheckConfigInput
  $enableEmail: Boolean
  $logo: String
) {
  updateUserClient(
    client: {
      _id: $_id
      name: $name
      userId: $userId
      descriptions: $descriptions
      jwtExpired: $jwtExpired
      allowedOrigins: $allowedOrigins
      registerDisabled: $registerDisabled
      showWXMPQRCode: $showWXMPQRCode
      useMiniLogin: $useMiniLogin
      emailVerifiedDefault: $emailVerifiedDefault
      frequentRegisterCheck: $frequentRegisterCheck
      loginFailCheck: $loginFailCheck
      enableEmail: $enableEmail
      logo: $logo
    }
  ) {
    _id
    name
    descriptions
    jwtExpired
    createdAt
    isDeleted
    allowedOrigins
    registerDisabled
    showWXMPQRCode
    useMiniLogin
    emailVerifiedDefault
    logo
    clientType {
      _id
      name
      description
      image
      example
    }
    user {
      _id
      email
      username
      emailVerified
    }
    frequentRegisterCheck {
      enable
      limit
      timeInterval
    }
    loginFailCheck {
      timeInterval
      limit
      enable
    }
    enableEmail
  }
}
''';
