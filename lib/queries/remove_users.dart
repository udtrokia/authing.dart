part of authing;

final String removeUsersQuery = r'''
mutation removeUsers($ids: [String], $registerInClient: String, $operator: String) {
    removeUsers(ids: $ids, registerInClient: $registerInClient, operator: $operator) {
        _id
    }
}
''';
