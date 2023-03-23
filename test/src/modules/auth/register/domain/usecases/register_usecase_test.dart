import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/repositories/register_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/usecases/register_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class RegisterRepositoryMock extends Mock implements RegisterRepository {}

main() {
  late RegisterRepository repository;
  late RegisterUseCase usecase;

  setUp(() {
    repository = RegisterRepositoryMock();
    usecase = RegisterUseCase(repository: repository);
  });

  const RegisterEntity registerInfo = RegisterEntity(
    company: "company",
    email: "teste@email.com",
    password: "password",
  );

  RegisterUserEntity registerUser = RegisterUserEntity(
    userId: '123',
    company: "company",
    username: "teste",
    email: "teste@email.com",
    createdAt: DateTime(2020),
  );

  test("Should register a user", () async {
    when(() => repository.register(registerInfo)).thenAnswer(
        (_) async => Right<Failure, RegisterUserEntity>(registerUser));
    final result = await usecase(registerInfo);

    expect(result, Right(registerUser));

    verify(() => repository.register(
          const RegisterEntity(
            company: "company",
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);

    verifyNoMoreInteractions(repository);
  });

  test("Should get InvalidCredentialsFailure from the Repository", () async {
    String messageError = "Error! Invalid Credentials";

    when(() => repository.register(registerInfo)).thenAnswer((_) async =>
        Left<Failure, RegisterUserEntity>(
            InvalidCredentialsFailure(messageError)));
    final result = await usecase(registerInfo);

    expect(result, Left(InvalidCredentialsFailure(messageError)));

    verify(() => repository.register(
          const RegisterEntity(
            company: "company",
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });

  test("Should get ServerFailure from the Repository", () async {
    String messageError = "Server Error! Try again later.";
    when(() => repository.register(registerInfo)).thenAnswer((_) async =>
        Left<Failure, RegisterUserEntity>(ServerFailure(messageError)));
    final result = await usecase(registerInfo);

    expect(result, Left(ServerFailure(messageError)));

    verify(() => repository.register(
          const RegisterEntity(
            company: "company",
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });

  test("Should get GeneralFailure from the Repository", () async {
    String messageError = "General Error!";
    when(() => repository.register(registerInfo)).thenAnswer((_) async =>
        Left<Failure, RegisterUserEntity>(GeneralFailure(messageError)));
    final result = await usecase(registerInfo);

    expect(result, Left(GeneralFailure(messageError)));

    verify(() => repository.register(
          const RegisterEntity(
            company: "company",
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });
}
