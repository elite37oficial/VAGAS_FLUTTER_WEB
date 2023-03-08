import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_login_entity.dart';

class AdminLoginModel extends AdminLoginEntity {
  const AdminLoginModel({
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  factory AdminLoginModel.fromMap(Map<String, dynamic> map) {
    return AdminLoginModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
