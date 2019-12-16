const query = r'''
query checkLoginStatus($token: String!) {
    checkLoginStatus(token: $token) {
        message
        code
        status
        token {
            data {
                email
                id
                clientId
                unionid
            }
            iat
            exp
        }
    }
}
''';
