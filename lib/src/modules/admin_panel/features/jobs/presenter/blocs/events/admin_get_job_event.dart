import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/presenter/blocs/states/admin_get_job_states.dart';

abstract class AdminGetJobEvent extends Equatable {
  const AdminGetJobEvent();
}

class AdminGetJobListEvent extends AdminGetJobEvent {
  final int page;

  const AdminGetJobListEvent({required this.page});

  @override
  List<Object> get props => [page];
}

class CleanAdminGetJobStateEvent extends AdminGetJobEvent {
  final AdminGetJobStates state;

  const CleanAdminGetJobStateEvent({
    required this.state,
  });

  @override
  List<AdminGetJobStates> get props => [state];
}
