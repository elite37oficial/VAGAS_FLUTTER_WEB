import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/states/get_users_states.dart';

abstract class AdminGetUsersEvent extends Equatable {
  const AdminGetUsersEvent();
}

class AdminDoGetUsersEvent extends AdminGetUsersEvent {
  final int page;

  const AdminDoGetUsersEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class AdminCleanGetUsersStateEvent extends AdminGetUsersEvent {
  final AdminGetUsersStates state;

  const AdminCleanGetUsersStateEvent({
    required this.state,
  });

  @override
  List<AdminGetUsersStates> get props => [state];
}
