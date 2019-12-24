part of authing;

final String getUserClientTypeQuery = r'''
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
