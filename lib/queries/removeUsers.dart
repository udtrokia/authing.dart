part of authing;

const removeUsersQuery = r'''
mutation removeUsers($ids: [String], $registerInClient: String, $operator: String) {
    removeUsers(ids: $ids, registerInClient: $registerInClient, operator: $operator) {
        _id
    }
}
''';
