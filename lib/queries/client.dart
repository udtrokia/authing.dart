part of authing;

const clientQuery = r'''
query client($id: String!, $userId: String!) {
  client(id: $id, userId: $userId) {
    _id
    name
    descriptions
    jwtExpired
    createdAt
    secret
    isDeleted
    logo
    emailVerifiedDefault
    registerDisabled
    showWXMPQRCode
    useMiniLogin
    allowedOrigins
    user {
      _id
      email
      username
      emailVerified
    }
    clientType {
      _id
      name
      description
      image
      example
    }
    frequentRegisterCheck {
      timeInterval
      limit
      enable
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
