part of authing;

const clientRolesQuery = r'''
query clientRoles($client:String!,$page:Int,$count:Int){
  clientRoles(client:$client,page:$page,count:$count){
    totalCount
    list{
      _id
      name
      descriptions
      client
      permissions
      createdAt
    }
  }
}
''';
