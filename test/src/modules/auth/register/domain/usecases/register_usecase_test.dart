import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/repositories/register_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/register/domain/usecases/register_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class RegisterRepositoryMock extends Mock implements RegisterRepository {}

main() {
  late RegisterRepository repository;
  late RegisterUsecase usecase;

  setUp(() {
    repository = RegisterRepositoryMock();
    usecase = RegisterUsecase(repository: repository);
  });

  const RegisterEntity registerInfo = RegisterEntity(
    name: "name",
    email: "teste@gmail.com",
    password: "password",
  );

  const RegisterUserEntity registerUser = RegisterUserEntity(
    userId: '',
    name: "name",
    email: "teste@gmail.com",
    password: "password",
  );

  test("Should register a user", () async {
    when(() => repository.register(registerInfo)).thenAnswer(
        (_) async => const Right<Failure, RegisterUserEntity>(registerUser));
    final result = await usecase(registerInfo);

    expect(result, const Right(registerUser));

    verify(() => repository.register(registerInfo)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test("Should get InvalidCredentialsFailure from the Repository", () async {
    String messageError = "Error! Invalid Credentials";

    when(() => repository.register(registerInfo)).thenAnswer((_) async =>
        Left<Failure, RegisterUserEntity>(
            InvalidCredentialsFailure(messageError)));
    final result = await usecase(registerInfo);

    expect(result, Left(InvalidCredentialsFailure(messageError)));

    verify(() => repository.register(registerInfo)).called(1);
  });

  test("Should get ServerFailure from the Repository", () async {
    String messageError = "Server Error! Try again later.";
    when(() => repository.register(registerInfo)).thenAnswer((_) async =>
        Left<Failure, RegisterUserEntity>(ServerFailure(messageError)));
    final result = await usecase(registerInfo);

    expect(result, Left(ServerFailure(messageError)));

    verify(() => repository.register(registerInfo)).called(1);
  });

  test("Should get GeneralFailure from the Repository", () async {
    String messageError = "General Error!";
    when(() => repository.register(registerInfo)).thenAnswer((_) async =>
        Left<Failure, RegisterUserEntity>(GeneralFailure(messageError)));
    final result = await usecase(registerInfo);

    expect(result, Left(GeneralFailure(messageError)));

    verify(() => repository.register(registerInfo)).called(1);
  });
}