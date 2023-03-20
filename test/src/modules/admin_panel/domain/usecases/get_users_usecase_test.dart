import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/repositories/get_users_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/usecases/get_users_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetUsersRepositoryMock extends Mock implements GetUsersRepository {}

main() {
  late GetUsersRepository repository;
  late GetUsersUsecase usecase;

  setUp(() {
    repository = GetUsersRepositoryMock();
    usecase = GetUsersUsecase(repository: repository);
  });

  List<UserEntity> listUsers = [
    const UserEntity(
      id: "0",
      name: "nome",
      email: "email@email.com",
      createdAt: "2023-2-2",
      listJobs: [],
    ),
    const UserEntity(
      id: "0",
      name: "nome",
      email: "email@email.com",
      createdAt: "2023-2-2",
      listJobs: [],
    ),
    const UserEntity(
      id: "0",
      name: "nome",
      email: "email@email.com",
      createdAt: "2023-2-2",
      listJobs: [],
    ),
  ];

  test("Should get List<UserEntity> from the Repository", () async {
    when(() => repository.getUsers())
        .thenAnswer((_) async => Right<Failure, List<UserEntity>>(listUsers));
    final result = await usecase(NoParams());

    expect(result, Right(listUsers));

    verify(() => repository.getUsers()).called(1);
  });

  test("Should get InvalidCredentialsFailure from the Repository", () async {
    String messageError = "Error! Invalid Credentials";

    when(() => repository.getUsers()).thenAnswer((_) async =>
        Left<Failure, List<UserEntity>>(
            InvalidCredentialsFailure(messageError)));
    final result = await usecase(NoParams());

    expect(result, Left(InvalidCredentialsFailure(messageError)));

    verify(() => repository.getUsers()).called(1);
  });

  test("Should get ServerFailure from the Repository", () async {
    String messageError = "Server Error! Try again later.";
    when(() => repository.getUsers()).thenAnswer((_) async =>
        Left<Failure, List<UserEntity>>(ServerFailure(messageError)));
    final result = await usecase(NoParams());

    expect(result, Left(ServerFailure(messageError)));

    verify(() => repository.getUsers()).called(1);
  });

  test("Should get GeneralFailure from the Repository", () async {
    String messageError = "General Error!";
    when(() => repository.getUsers()).thenAnswer((_) async =>
        Left<Failure, List<UserEntity>>(GeneralFailure(messageError)));
    final result = await usecase(NoParams());

    expect(result, Left(GeneralFailure(messageError)));

    verify(() => repository.getUsers()).called(1);
  });
}
