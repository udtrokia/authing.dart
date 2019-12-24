part of authing;

final String isClientBelongToUserQuery = r'''
query isClientBelongToUser(
    $userId: String
    $clientId: String
    $permissionDescriptors: [permissionDescriptorsListInputType]
) {
    isClientBelongToUser(userId: $userId, clientId: $clientId, permissionDescriptors: $permissionDescriptors)
}
''';
