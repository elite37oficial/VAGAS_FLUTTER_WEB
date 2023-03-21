import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/repositories/get_users_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/datasources/get_users_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/models/get_users_response_model.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/repositories/get_users_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/helpers/exceptions/request_exception.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetUsersDatasourceMock extends Mock implements GetUsersDatasource {}

main() {
  late GetUsersDatasource datasource;
  late GetUsersRepository repository;

  setUp(() {
    datasource = GetUsersDatasourceMock();
    repository = GetUsersRepositoryImplementation(datasource: datasource);
  });

  GetUsersResponseModel getUsersResponseModel = GetUsersResponseModel(
    listUsers: [],
  );

  test("Should return a GetUsersResponseModel when calls the datasource",
      () async {
    when(() => datasource.getUsers())
        .thenAnswer((_) async => getUsersResponseModel);

    final result = await repository.getUsers();

    expect(result, Right(getUsersResponseModel.listUsers));
    verify(() => datasource.getUsers()).called(1);
  });

  test(
      "Should return a InvalidCredentialsFailure when get InvalidCredentialsException from datasource",
      () async {
    var message = "Error! Invalid Credentials.";
    when(() => datasource.getUsers()).thenThrow(
        InvalidCredentialsException(message: message, statusCode: 401));

    final result = await repository.getUsers();

    expect(result, Left(InvalidCredentialsFailure(message)));

    verify(() => datasource.getUsers()).called(1);
  });

  test("Should return a ServerFailure when get ServerException from datasource",
      () async {
    var message = "Server Error!";
    when(() => datasource.getUsers())
        .thenThrow(ServerException(message: message, statusCode: 500));

    final result = await repository.getUsers();

    expect(result, Left(ServerFailure(message)));
    verify(() => datasource.getUsers()).called(1);
  });
}
