const query = r'''
query user(
  $id: String!
  $registerInClient: String!
  $userLoginHistoryPage: Int
  $userLoginHistoryCount: Int
) {
  user(
    id: $id
    registerInClient: $registerInClient
    userLoginHistoryPage: $userLoginHistoryPage
    userLoginHistoryCount: $userLoginHistoryCount
  ) {
    _id
    email
    phone
    emailVerified
    username
    nickname
    unionid
    openid
    company
    photo
    browser
    device
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
    group {
      _id
      name
      descriptions
      createdAt
    }
    clientType {
      _id
      name
      description
      image
      example
    }
    userLocation {
      _id
      when
      where
    }
    userLoginHistory {
      totalCount
      list {
        _id
        when
        success
        ip
        result
        device
        browser
      }
    }
    systemApplicationType {
      _id
      name
      descriptions
      price
    }
  }
}
''';
