import 'package:flutter_test/flutter_test.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/infra/models/admin_login_model.dart';

main() {
  late AdminLoginModel loginModel;

  setUp(() {
    loginModel = const AdminLoginModel(
      email: "teste@email.com",
      password: "password",
    );
  });

  test("Should be a subclass of AdminLoginEntity", () {
    expect(loginModel, isA<AdminLoginEntity>());
  });

  test("Should return a valid AdminLoginModel from a Map", () {
    final Map<String, dynamic> map = {
      "email": "teste@email.com",
      "password": "password",
    };

    final result = AdminLoginModel.fromMap(map);

    expect(result, isA<AdminLoginModel>());
  });

  test("Should return Map containing the AdminLoginModel data", () {
    final expectedMap = {"email": "teste@email.com", "password": "password"};

    final result = loginModel.toMap();

    expect(result, expectedMap);
  });
}
