part of authing;

final String changePasswordQuery = r'''
mutation ChangePassword(
  $email: String!
  $client: String!
  $password: String!
  $verifyCode: String!
) {
  changePassword(
    email: $email
    client: $client
    password: $password
    verifyCode: $verifyCode
  ) {
    _id
    email
    emailVerified
    username
    nickname
    company
    photo
    browser
    registerInClient
    registerMethod
    oauth
    token
    tokenExpiredAt
    loginsCount
    lastLogin
    lastIP
    signedUp
    blocked
    isDeleted
  }
}  
''';
