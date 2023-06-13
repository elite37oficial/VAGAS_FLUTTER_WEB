import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/entities/admin_get_users_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/usecases/admin_get_users_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/events/get_users_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/states/get_users_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminGetUsersBloc extends Bloc<AdminGetUsersEvent, AdminGetUsersStates> {
  final AdminGetUsersUsecase usecase;
  AdminGetUsersBloc({required this.usecase})
      : super(AdminGetUsersInitialState()) {
    on<AdminDoGetUsersEvent>(adminGetUsers);
    on<AdminCleanGetUsersStateEvent>(cleanState);
  }

  void adminGetUsers(
    AdminDoGetUsersEvent event,
    Emitter<AdminGetUsersStates> emitter,
  ) async {
    emitter(AdminGetUsersLoadingState());

    var result = await usecase(event.page);

    result.fold(
      (Failure failure) => emitter(
          AdminGetUsersErrorState(message: failure.props.first.toString())),
      (AdminGetUsersResponseEntity success) =>
          emitter(AdminGetUsersSuccessState(listUsers: success)),
    );
  }

  Future<void> cleanState(
    AdminCleanGetUsersStateEvent event,
    Emitter<AdminGetUsersStates> emitter,
  ) async =>
      emitter(event.state);
}
