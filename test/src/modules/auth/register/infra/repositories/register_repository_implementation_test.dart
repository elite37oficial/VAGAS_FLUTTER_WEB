import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/datasources/register_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/models/register_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/models/register_user_model.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/infra/repositories/register_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class RegisterDatasourceMock extends Mock implements RegisterDatasource {}

main() {
  late RegisterRepositoryImplementation repository;
  late RegisterDatasource datasource;

  setUp(() {
    datasource = RegisterDatasourceMock();
    repository = RegisterRepositoryImplementation(datasource);
  });

  RegisterUserModel registerUserModel = const RegisterUserModel(
    userId: "123",
    email: "teste@gmail.com",
    name: "name",
    password: "password",
  );

  RegisterModel registerModel = const RegisterModel(
    name: '',
    email: '',
    password: '',
  );

  test("Should return a RegisterModel when calls the datasource", () async {
    when(() => datasource.register(registerModel))
        .thenAnswer((_) async => registerUserModel);

    final result = await repository.register(registerModel);

    expect(result, Right(registerUserModel));
    verify(() => datasource.register(registerModel)).called(1);
  });

  test(
      "Should return a InvalidCredentialsFailure when get InvalidCredentialsException from datasource",
      () async {
    var message = "Error! Invalid Credentials.";
    when(() => datasource.register(registerModel)).thenThrow(
        InvalidCredentialsException(message: message, statusCode: 401));

    final result = await repository.register(registerModel);

    expect(result, Left(InvalidCredentialsFailure(message)));

    verify(() => datasource.register(registerModel)).called(1);
  });

  test("Should return a ServerFailure when get ServerException from datasource",
      () async {
    var message = "Server Error!";
    when(() => datasource.register(registerModel))
        .thenThrow(ServerException(message: message, statusCode: 500));

    final result = await repository.register(registerModel);

    expect(result, Left(ServerFailure(message)));
    verify(() => datasource.register(registerModel)).called(1);
  });
}
