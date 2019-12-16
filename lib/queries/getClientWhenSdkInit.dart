const query = r'''
query getClientWhenSdkInit(
    $secret: String
    $clientId: String
    $retUserId: Boolean
    $timestamp: String
    $signature: String
    $nonce: Int
) {
    getClientWhenSdkInit(
        secret: $secret
        clientId: $clientId
        retUserId: $retUserId
        timestamp: $timestamp
        signature: $signature
        nonce: $nonce
    ) {
        clientInfo {
            _id
            user {
                _id
                username
            }
            clientType {
                _id
                name
                description
                image
                example
            }
            usersCount
            logo
            emailVerifiedDefault
            registerDisabled
            showWXMPQRCode
            useMiniLogin
            allowedOrigins
            name
            secret
            token
            descriptions
            jwtExpired
            createdAt
            isDeleted
            frequentRegisterCheck {
                timeInterval
                limit
                enable
            }
            loginFailCheck {
                timeInterval
                limit
                enable
            }
            enableEmail
        }
        accessToken
    }
}    
'''
