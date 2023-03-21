import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/usecases/get_users_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/events/get_users_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/states/get_users_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetUsersUsecaseMock extends Mock implements GetUsersUsecase {}

main() {
  late GetUsersBloc bloc;
  late GetUsersUsecase usecase;

  setUp(() {
    usecase = GetUsersUsecaseMock();
    bloc = GetUsersBloc(usecase: usecase);
  });

  tearDown(() {
    bloc.close();
  });

  List<UserEntity> listUsersEntity = [
    const UserEntity(
      id: "1",
      email: "email@email.com",
      name: "nome",
      createdAt: "2017-09-07",
      listJobs: [],
    ),
    const UserEntity(
      id: "1",
      email: "email@email.com",
      name: "nome",
      createdAt: "2017-09-07",
      listJobs: [],
    ),
  ];

  test("Should return a GetUsersInitialState from Initial State", () async {
    expect(bloc.state, isA<GetUsersInitialState>());
  });

  blocTest(
    'Emits GetUsersSuccessState when GetEvent is added',
    setUp: () => when(
        () => usecase(NoParams()).then((_) async => Right(listUsersEntity))),
    build: () => bloc,
    verify: (_) {
      verify(() => usecase(NoParams())).called(1);
    },
    act: (bloc) => bloc.add(GetEvent()),
  );
}
