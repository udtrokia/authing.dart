part of authing;

const loginQuery = r'''
mutation login(
  $email: String
  $password: String
  $lastIP: String
  $registerInClient: String!
  $verifyCode: String
  $phone: String
  $username: String
  $browser: String
) {
  login(
    email: $email
    password: $password
    lastIP: $lastIP
    registerInClient: $registerInClient
    verifyCode: $verifyCode
    phone: $phone
    username: $username
    browser: $browser
  ) {
    _id
    email
    emailVerified
    username
    nickname
    company
    photo
    browser
    password
    token
    loginsCount
    group {
      name
    }
    blocked
  }
}
''';
