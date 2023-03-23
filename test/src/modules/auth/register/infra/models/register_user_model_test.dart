import 'package:flutter_test/flutter_test.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/models/register_user_model.dart';

main() {
  late RegisterUserModel registerUserModel;

  setUp(() {
    registerUserModel = RegisterUserModel(
      userId: "123",
      company: "company",
      username: "username",
      email: "teste@email.com",
      createdAt: DateTime(2020, 02),
    );
  });

  test("Should be a subclass of RegisterUserEntity", () {
    expect(registerUserModel, isA<RegisterUserEntity>());
  });

  test("Should return a valid RegisterUserModel from a Map", () {
    final Map<String, dynamic> map = {
      "company": "company",
      "email": "teste@email.com",
      "password": "password",
    };

    final result = RegisterUserModel.fromMap(map);

    expect(result, isA<RegisterUserModel>());
  });

  test("Should return Map containing the RegisterUserModel data", () {
    final expectedMap = {
      "userId": "123",
      "company": "company",
      "email": "teste@email.com",
      "username": "username",
    };

    final result = registerUserModel.toMap();

    expect(result, expectedMap);
  });
}
