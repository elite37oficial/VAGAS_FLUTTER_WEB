part of '../blocs/get_job_bloc.dart';

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
