import 'dart:convert';

class DecodedTokenEntity {
  final String roles;
  final String userID;

  const DecodedTokenEntity({required this.roles, required this.userID});

  Map<String, dynamic> toMap() {
    return {
      'roles': roles,
      'userID': userID,
    };
  }

  factory DecodedTokenEntity.fromMap(Map<String, dynamic> map) {
    return DecodedTokenEntity(
      roles: map['roles'] ?? '',
      userID: map['userID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DecodedTokenEntity.fromJson(String source) =>
      DecodedTokenEntity.fromMap(json.decode(source));
}
