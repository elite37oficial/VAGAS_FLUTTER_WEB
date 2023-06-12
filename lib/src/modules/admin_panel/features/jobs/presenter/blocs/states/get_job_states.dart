part of '../blocs/get_job_bloc.dart';

abstract class AdminGetJobStates {}

class AdminGetJobInitialState extends AdminGetJobStates {}

class AdminGetJobLoadingState extends AdminGetJobStates {}

class AdminGetJobSuccessState extends AdminGetJobStates {
  final AdminGetJobResponseEntity listJobs;

  AdminGetJobSuccessState({required this.listJobs});
}

class AdminGetJobErrorState extends AdminGetJobStates {
  final String message;

  AdminGetJobErrorState({required this.message});
}
