const query = r'''
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
