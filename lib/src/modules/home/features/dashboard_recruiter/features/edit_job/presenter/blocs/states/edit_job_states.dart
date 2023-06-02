part of '../blocs/edit_job_bloc.dart';

abstract class EditJobStates {}

class EditJobInitialState extends EditJobStates {}

class EditJobLoadingState extends EditJobStates {}

class EditJobSuccessState extends EditJobStates {
  final bool response;

  EditJobSuccessState({required this.response});
}

class EditJobErrorState extends EditJobStates {
  final String message;

  EditJobErrorState({required this.message});
}
