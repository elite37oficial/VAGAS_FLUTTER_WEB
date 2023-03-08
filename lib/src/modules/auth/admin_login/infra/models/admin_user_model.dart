import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';

class AdminUserModel extends AdminUserEntity {
  const AdminUserModel({
    required super.userId,
    required super.username,
    required super.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
    };
  }

  factory AdminUserModel.fromMap(Map<String, dynamic> map) {
    return AdminUserModel(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
