import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/domain/usecases/get_users_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/events/get_users_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/presenter/blocs/states/get_users_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersStates> {
  final GetUsersUsecase usecase;
  GetUsersBloc({required this.usecase}) : super(GetUsersInitialState()) {
    on<GetEvent>(getUsers);
  }

  void getUsers(
    GetUsersEvent event,
    Emitter<GetUsersStates> emitter,
  ) async {
    emitter(GetUsersLoadingState());

    var result = await usecase(NoParams());

    result.fold(
      (Failure failure) =>
          emitter(GetUsersErrorState(message: failure.props.first.toString())),
      (List<UserEntity> success) =>
          emitter(GetUsersSuccessState(listUsers: success)),
    );
  }
}
