part of '../blocs/get_job_bloc.dart';

abstract class GetJobEvent extends Equatable {
  const GetJobEvent();
}

class GetJobListEvent extends GetJobEvent {
  @override
  List<Object> get props => [];
}
