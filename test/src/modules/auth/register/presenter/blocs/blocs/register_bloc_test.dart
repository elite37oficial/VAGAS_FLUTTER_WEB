import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/usecases/register_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/blocs/blocs/register_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/blocs/states/register_state.dart';
class RegisterUsecaseMock extends Mock implements RegisterUseCase {}

main() {
  late RegisterBloc bloc;
  late RegisterUseCase usecase;

  setUp(() {
    usecase = RegisterUsecaseMock();
    bloc = RegisterBloc(usecase: usecase);
  });

  tearDown(() {
    bloc.close();
  });

  RegisterEntity registerEntity = const RegisterEntity(
    company: "company",
    email: "teste@email.com",
    password: "password",
  );

  RegisterUserEntity userEntity = RegisterUserEntity(
    userId: "123",
    company: "company",
    email: "teste@email.com",
    username: "teste",
    createdAt: DateTime(2020),
  );

  test("Should return a RegisterInitialState from Initial State", () async {
    expect(bloc.state, isA<RegisterInitialState>());
  });

  blocTest(
    'Emits RegisterSuccessState when RegisterUserEvent is added',
    setUp: () => when(
        () => usecase(registerEntity).then((_) async => Right(userEntity))),
    build: () => bloc,
    verify: (_) {
      verify(() => usecase(registerEntity)).called(1);
    },
    act: (bloc) => bloc.add(RegisterUserEvent(
        company: registerEntity.company,
        email: registerEntity.email,
        password: registerEntity.password)),
  );
}
