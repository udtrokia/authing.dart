part of authing;

const getUserClientTypeQuery = r'''
query getUserClientType {
    userClientTypes {
        _id
        name
        description
        image
        example
    }
}  
''';
