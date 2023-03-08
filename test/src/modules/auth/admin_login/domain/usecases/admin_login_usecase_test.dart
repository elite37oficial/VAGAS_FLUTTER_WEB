import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/repositories/admin_login_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/usecases/admin_login_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminrepositoryMock extends Mock implements AdminLoginRepository {}

main() {
  late AdminLoginRepository repository;
  late AdminLoginUsecase usecase;

  setUp(() {
    repository = AdminrepositoryMock();
    usecase = AdminLoginUsecase(repository: repository);
  });

  const AdminLoginEntity loginInfo = AdminLoginEntity(
    email: "teste@email.com",
    password: "password",
  );

  const AdminUserEntity adminUser = AdminUserEntity(
    userId: "123",
    username: "teste",
    email: "teste@email.com",
  );

  test("Should get AdminUserEntity from the Repository", () async {
    when(() => repository.login(loginInfo)).thenAnswer(
        (_) async => const Right<Failure, AdminUserEntity>(adminUser));
    final result = await usecase(loginInfo);

    expect(result, const Right(adminUser));

    verify(() => repository.login(
          const AdminLoginEntity(
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });

  test("Should get InvalidCredentialsFailure from the Repository", () async {
    String messageError = "Error! Invalid Credentials";

    when(() => repository.login(loginInfo)).thenAnswer((_) async =>
        Left<Failure, AdminUserEntity>(
            InvalidCredentialsFailure(messageError)));
    final result = await usecase(loginInfo);

    expect(result, Left(InvalidCredentialsFailure(messageError)));

    verify(() => repository.login(
          const AdminLoginEntity(
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });

  test("Should get ServerFailure from the Repository", () async {
    String messageError = "Server Error! Try again later.";
    when(() => repository.login(loginInfo)).thenAnswer((_) async =>
        Left<Failure, AdminUserEntity>(ServerFailure(messageError)));
    final result = await usecase(loginInfo);

    expect(result, Left(ServerFailure(messageError)));

    verify(() => repository.login(
          const AdminLoginEntity(
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });

  test("Should get GeneralFailure from the Repository", () async {
    String messageError = "General Error!";
    when(() => repository.login(loginInfo)).thenAnswer((_) async =>
        Left<Failure, AdminUserEntity>(GeneralFailure(messageError)));
    final result = await usecase(loginInfo);

    expect(result, Left(GeneralFailure(messageError)));

    verify(() => repository.login(
          const AdminLoginEntity(
            email: "teste@email.com",
            password: "password",
          ),
        )).called(1);
  });
}
