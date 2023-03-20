import 'package:flutter_test/flutter_test.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/infra/models/admin_user_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';

main() {
  late AdminUserModel userModel;

  setUp(() {
    userModel = AdminUserModel(
      userId: "123",
      username: "teste",
      email: "teste@email.com",
      createdAt: DateTime(2017, 9, 7),
    );
  });

  test("Should be a subclass of AdminUserEntity", () {
    expect(userModel, isA<AdminUserEntity>());
  });

  test("Should return a valid AdminUserModel from a Map", () {
    final Map<String, dynamic> map = {
      "email": "teste@email.com",
      "password": "password",
    };

    final result = AdminUserModel.fromMap(map);

    expect(result, isA<AdminUserModel>());
  });

  test("Should return Map containing the AdminUserModel data", () {
    final expectedMap = {
      "userId": "123",
      "username": "teste",
      "email": "teste@email.com"
    };

    final result = userModel.toMap();

    expect(result, expectedMap);
  });
}
