part of "../blocs/create_job_bloc.dart";

abstract class CreateJobStates {}

class CreateJobInitialState extends CreateJobStates {}

class CreateJobLoadingState extends CreateJobStates {}

class CreateJobSuccessState extends CreateJobStates {
  final bool response;

  CreateJobSuccessState({required this.response});
}

class CreateJobErrorState extends CreateJobStates {
  final String message;

  CreateJobErrorState({required this.message});
}
