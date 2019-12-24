part of authing;

final String removeUserFromGroupQuery = r'''
mutation removeUserFromGroup($client:String!, $user:String!, $group:String!){
  removeUserFromGroup(client:$client, user:$user, group:$group){
    _id
    user{
      _id
      name
    }
    client{
      _id
      name
    }
    group{
      _id
      name
    }
    createdAt
  }
}
''';
