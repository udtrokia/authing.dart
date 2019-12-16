const query = r'''
mutation assignUserToRole($client:String!, $user:String!, $group:String!){
  assignUserToRole(client:$client, user:$user, group:$group){
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
