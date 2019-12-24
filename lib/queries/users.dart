part of authing;

final String usersQuery = r'''
query users($registerInClient: String, $page: Int, $count: Int, $populate: Boolean) {
    users(registerInClient: $registerInClient, page: $page, count: $count, populate: $populate) {
        totalCount
        list {
            _id
            email
            emailVerified
            username
            nickname
            photo
            loginsCount
            lastLogin
            phone
        }
    }
}    
''';
