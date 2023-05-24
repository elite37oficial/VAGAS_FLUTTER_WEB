part of '../blocs/get_job_by_id_bloc.dart';

abstract class GetJobByIdStates {}

class GetJobByIdInitialState extends GetJobByIdStates {}

class GetJobByIdLoadingState extends GetJobByIdStates {}

class GetJobByIdSuccessState extends GetJobByIdStates {
  final JobEntity response;

  GetJobByIdSuccessState({required this.response});
}

class GetJobByIdErrorState extends GetJobByIdStates {
  final String message;

  GetJobByIdErrorState({required this.message});
}
