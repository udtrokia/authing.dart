part of authing;

final String queryRoleByUserIdQuery = r'''
query QueryRoleByUserId($user:String!,$client:String!){
  queryRoleByUserId(client:$client,user:$user){
    totalCount
    list{
      group{
          _id
          name
        descriptions
        client
        permissions
        createdAt
      }
    }
  }
}
''';
