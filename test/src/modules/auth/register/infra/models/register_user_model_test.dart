import 'package:flutter_test/flutter_test.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/models/register_user_model.dart';

main() {
  late RegisterUserModel registerUserModel;

  setUp(() {
    registerUserModel = const RegisterUserModel(
      userId: "123",
      email: "teste@email.com",
      name: "name",
      password: "password",
    );
  });

  test("Should be a subclass of RegisterUserEntity", () {
    expect(registerUserModel, isA<RegisterUserEntity>());
  });

  test("Should return a valid RegisterUserModel from a Map", () {
    final Map<String, dynamic> map = {
      "userId": "123",
      "email": "teste@email.com",
      "password": "password",
      "name": "name",
    };

    final result = RegisterUserModel.fromMap(map);

    expect(result, isA<RegisterUserModel>());
  });

  test("Should return Map containing the RegisterUserModel data", () {
    final expectedMap = {
      "userId": "123",
      "email": "teste@email.com",
      "name": "name",
      "password": "password",
    };

    final result = registerUserModel.toMap();

    expect(result, expectedMap);
  });
}
