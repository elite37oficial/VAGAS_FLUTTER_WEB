import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/entities/get_users_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/usecases/get_users_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/events/get_users_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/states/get_users_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetUsersBloc extends Bloc<GetUsersEvent, GetUsersStates> {
  final GetUsersUsecase usecase;
  GetUsersBloc({required this.usecase}) : super(GetUsersInitialState()) {
    on<DoGetUsersEvent>(adminGetUsers);
    on<CleanGetUsersStateEvent>(cleanState);
  }

  void adminGetUsers(
    DoGetUsersEvent event,
    Emitter<GetUsersStates> emitter,
  ) async {
    emitter(GetUsersLoadingState());

    var result = await usecase(event.page);

    result.fold(
      (Failure failure) =>
          emitter(GetUsersErrorState(message: failure.props.first.toString())),
      (GetUsersResponseEntity success) =>
          emitter(GetUsersSuccessState(listUsers: success)),
    );
  }

  Future<void> cleanState(
    CleanGetUsersStateEvent event,
    Emitter<GetUsersStates> emitter,
  ) async =>
      emitter(event.state);
}
