part of authing;

final String registerQuery = r'''
mutation register(
    $username: String
    $email: String
    $password: String!
    $lastIP: String
    $forceLogin: Boolean
    $registerInClient: String!
    $phone: String
    $invitationCode: String
    $browser: String
    ) {
    register(
        userInfo: {
        email: $email
        password: $password
        lastIP: $lastIP
        forceLogin: $forceLogin
        registerInClient: $registerInClient
        phone: $phone
        username: $username
        browser: $browser
        }
        invitationCode: $invitationCode
    ) {
        _id
        email
        emailVerified
        username
        nickname
        company
        photo
        phone
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
