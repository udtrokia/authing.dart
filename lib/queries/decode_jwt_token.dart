part of authing;

final String decodeJwtTokenQuery = r'''
query decodeJwtToken($token: String!){
  decodeJwtToken(token: $token){
    data{
      email
      id
      clientId
      unionid
    }
    status{
      message
      code
      status
    }
    iat
    exp
  }
}
''';
