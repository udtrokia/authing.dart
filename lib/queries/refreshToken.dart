const query = r'''
mutation RefreshToken($client: String!, $user: String!) {
    refreshToken(client: $client, user: $user) {
        token
        iat
        exp
    }
}
''';
