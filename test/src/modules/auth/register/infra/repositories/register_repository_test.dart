import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/repositories/register_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/datasources/register_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/models/register_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/models/register_user_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/repositories/register_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class RegisterDatasourceMock extends Mock implements RegisterDatasource {}

main() {
  late RegisterDatasource datasource;
  late RegisterRepository repository;

  setUp(() {
    datasource = RegisterDatasourceMock();
    repository = RegisterRepositoryImplementation(datasource: datasource);
  });

  RegisterUserModel registerUserModel = RegisterUserModel(
    userId: "123",
    company: "company",
    username: "username",
    email: "teste@email.com",
    createdAt: DateTime(2020, 02),
  );

  RegisterModel registerModel = const RegisterModel(
    company: 'company',
    email: 'teste@email.com',
    password: 'password',
  );

  test("Should return a RegisterModel when calls the datasource", () async {
    when(() => datasource.register(registerModel))
        .thenAnswer((_) async => registerUserModel);

    final result = await repository.register(registerModel);

    expect(result, Right(registerUserModel));
    verify(() => datasource.register(
          const RegisterModel(
            company: "company",
            email: "email",
            password: "password",
          ),
        )).called(1);
  });

  test(
      "Should return a InvalidCredentialsFailure when get InvalidCredentialsException from datasource",
      () async {
    var message = "Error! Invalid Credentials.";
    when(() => datasource.register(registerModel)).thenThrow(
        InvalidCredentialsException(message: message, statusCode: 401));

    final result = await repository.register(
      const RegisterModel(
        company: "company",
        email: "email",
        password: "password",
      ),
    );

    expect(result, Left(InvalidCredentialsFailure(message)));

    verify(() => datasource.register(registerModel)).called(1);
  });

  test("Should return a ServerFailure when get ServerException from datasource",
      () async {
    var message = "Server Error!";
    when(() => datasource.register(registerModel))
        .thenThrow(ServerException(message: message, statusCode: 500));

    final result = await repository.register(
      const RegisterModel(
        company: "company",
        email: "email",
        password: "password",
      ),
    );

    expect(result, Left(ServerFailure(message)));
    verify(() => datasource.register(registerModel)).called(1);
  });
}
