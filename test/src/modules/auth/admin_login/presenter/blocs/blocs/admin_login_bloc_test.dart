import 'package:bloc/bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/usecases/admin_login_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/blocs/admin_login_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/events/admin_login_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/states/admin_login_state.dart';

class AdminLoginUsecaseMock extends Mock implements AdminLoginUsecase {}

main() {
  late AdminLoginBloc bloc;
  late AdminLoginUsecase usecase;

  setUp(() {
    usecase = AdminLoginUsecaseMock();
    bloc = AdminLoginBloc(usecase: usecase);
  });

  tearDown(() {
    bloc.close();
  });

  AdminLoginEntity loginEntity = const AdminLoginEntity(
    email: "teste@email.com",
    password: "password",
  );

  AdminUserEntity userEntity = AdminUserEntity(
    userId: "123",
    email: "teste@email.com",
    username: "teste",
    createdAt: DateTime(2017, 9, 7),
  );

  test("Should return a AdminLoginInitialState from Initial State", () async {
    expect(bloc.state, isA<AdminLoginInitialState>());
  });

  blocTest(
    'Emits AdminLoginSuccessState when LoginEvent is added',
    setUp: () =>
        when(() => usecase(loginEntity).then((_) async => Right(userEntity))),
    build: () => bloc,
    verify: (_) {
      verify(() => usecase(loginEntity)).called(1);
    },
    act: (bloc) => bloc.add(
        LoginEvent(email: loginEntity.email, password: loginEntity.password)),
    // wait: const Duration(milliseconds: 300),
    // expect: () => [isA<AdminLoginSuccessState>()],
  );

  // test("Should return a Failure from the usecase when there is an error",
  //     () async {
  //   when(() => usecaseMock(tLoginInfo))
  //       .thenAnswer((_) async => Left(ServerFailure()));

  //   await authStore.login(tLoginInfo);
  //   var state = authStore.state as AuthStateError;

  //   expect(state.error, ServerFailure());

  //   verify(() =>
  //           usecaseMock({"email": "email@email.com", "password": "senha123"}))
  //       .called(1);
  // });
}
