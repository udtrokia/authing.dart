part of authing;

final String changeMFAQuery = r'''
mutation changeMFA($_id: String, $userId: String, $userPoolId: String, $enable: Boolean!, $refreshKey: Boolean) {
    changeMFA(_id: $_id, userId: $userId, userPoolId: $userPoolId, enable: $enable, refreshKey: $refreshKey) {
        _id
        userId
        userPoolId
        enable
        shareKey
    }
}    
''';
