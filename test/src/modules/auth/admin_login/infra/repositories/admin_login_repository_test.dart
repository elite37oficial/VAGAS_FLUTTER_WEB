import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/domain/repositories/admin_login_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/datasources/admin_login_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/models/admin_login_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/models/admin_user_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/admin_login/infra/repositories/admin_login_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminLoginDatasourceMock extends Mock implements AdminLoginDatasource {}

main() {
  late AdminLoginDatasource datasource;
  late AdminLoginRepository repository;

  setUp(() {
    datasource = AdminLoginDatasourceMock();
    repository = AdminLoginRepositoryImplementation(datasource: datasource);
  });

  AdminUserModel adminUserModel = AdminUserModel(
    userId: "123",
    username: "teste",
    email: "teste@email.com",
    createdAt: DateTime(2017, 9, 7),
  );

  AdminLoginModel adminLoginModel = const AdminLoginModel(
    email: "teste@email.com",
    password: "password",
  );

  test("Should return a AdminLoginModel when calls the datasource", () async {
    when(() => datasource.login(adminLoginModel))
        .thenAnswer((_) async => adminUserModel);

    final result = await repository.login(adminLoginModel);

    expect(result, Right(adminUserModel));
    verify(() => datasource.login(
          const AdminLoginModel(
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });

  test(
      "Should return a InvalidCredentialsFailure when get InvalidCredentialsException from datasource",
      () async {
    var message = "Error! Invalid Credentials.";
    when(() => datasource.login(adminLoginModel)).thenThrow(
        InvalidCredentialsException(message: message, statusCode: 401));

    final result = await repository.login(adminLoginModel);

    expect(result, Left(InvalidCredentialsFailure(message)));

    verify(() => datasource.login(
          const AdminLoginModel(
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });

  test("Should return a ServerFailure when get ServerException from datasource",
      () async {
    var message = "Server Error!";
    when(() => datasource.login(adminLoginModel))
        .thenThrow(ServerException(message: message, statusCode: 500));

    final result = await repository.login(adminLoginModel);

    expect(result, Left(ServerFailure(message)));
    verify(() => datasource.login(
          const AdminLoginModel(
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });
}
