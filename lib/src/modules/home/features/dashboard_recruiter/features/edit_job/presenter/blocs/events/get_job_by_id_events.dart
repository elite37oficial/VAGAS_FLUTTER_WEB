part of '../blocs/get_job_by_id_bloc.dart';

abstract class GetJobByIdEvent extends Equatable {
  const GetJobByIdEvent();
}

class DoGetJobByIdEvent extends GetJobByIdEvent {
  final String jobId;

  const DoGetJobByIdEvent({required this.jobId});

  @override
  List<Object> get props => [jobId];
}

class CleanGetJobByIdStateEvent extends GetJobByIdEvent {
  final GetJobByIdStates state;

  const CleanGetJobByIdStateEvent({
    required this.state,
  });

  @override
  List<GetJobByIdStates> get props => [state];
}
