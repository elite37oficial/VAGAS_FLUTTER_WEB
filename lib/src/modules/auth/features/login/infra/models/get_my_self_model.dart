import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/get_my_self_entity.dart';

class GetMySelfModel extends GetMySelfEntity {
  const GetMySelfModel({
    required super.email,
    required super.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'token': token,
    };
  }

  factory GetMySelfModel.fromMap(Map<String, dynamic> map) {
    return GetMySelfModel(
      email: map['email'] ?? '',
      token: map['token'] ?? '',
    );
  }
}
