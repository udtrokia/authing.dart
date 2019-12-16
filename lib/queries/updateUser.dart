const query = r'''
mutation UpdateUser(
  $id: String!
  $email: String
  $username: String
  $photo: String
  $nickname: String
  $company: String
  $password: String
  $oldPassword: String
  $registerInClient: String
  $phone: String
  $browser: String
) {
  updateUser(
    options: {
      _id: $id
      email: $email
      username: $username
      photo: $photo
      nickname: $nickname
      company: $company
      password: $password
      oldPassword: $oldPassword
      registerInClient: $registerInClient
      phone: $phone
      browser: $browser
    }
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
