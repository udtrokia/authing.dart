part of authing;

final String refreshTokenQuery = r'''
mutation RefreshToken($client: String!, $user: String!) {
    refreshToken(client: $client, user: $user) {
        token
        iat
        exp
    }
}
''';
