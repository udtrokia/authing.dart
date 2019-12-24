part of authing;

final String createRoleQuery = r'''
mutation createRole($client:String!, $name:String!,$descriptions: String){
  createRole(client:$client,name:$name,descriptions:$descriptions){
    _id
    name
    descriptions
    client
    permissions
    createdAt
  }
}
''';
