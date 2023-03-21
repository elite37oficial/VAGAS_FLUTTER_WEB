import 'package:flutter_test/flutter_test.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/models/register_model.dart';

main() {
  late RegisterModel registerModel;

  setUp(() {
    registerModel = const RegisterModel(
      company: 'company',
      email: "teste@email.com",
      password: "password",
    );
  });

  test("Should be a subclass of RegisterEntity", () {
    expect(registerModel, isA<RegisterEntity>());
  });

  test("Should return a valid RegisterModel from a Map", () {
    final Map<String, dynamic> map = {
      "company": "company",
      "email": "teste@email.com",
      "password": "password",
    };

    final result = RegisterModel.fromMap(map);

    expect(result, isA<RegisterModel>());
  });

  test("Should return Map containing the RegisterModel data", () {
    final expectedMap = {
      "company": "company",
      "email": "teste@email.com",
      "password": "password",
    };

    final result = registerModel.toMap();

    expect(result, expectedMap);
  });
}
