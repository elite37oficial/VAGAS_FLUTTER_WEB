import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  const TokenModel({required super.token});

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      token: map["token"] ?? '',
    );
  }
}
