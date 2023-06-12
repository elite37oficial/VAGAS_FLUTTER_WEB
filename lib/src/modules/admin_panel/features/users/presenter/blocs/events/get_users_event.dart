import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/states/get_users_states.dart';

abstract class GetUsersEvent extends Equatable {
  const GetUsersEvent();
}

class DoGetUsersEvent extends GetUsersEvent {
  final int page;

  const DoGetUsersEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class CleanGetUsersStateEvent extends GetUsersEvent {
  final GetUsersStates state;

  const CleanGetUsersStateEvent({
    required this.state,
  });

  @override
  List<GetUsersStates> get props => [state];
}
