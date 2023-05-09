part of '../blocs/get_job_bloc.dart';

abstract class GetJobEvent extends Equatable {
  const GetJobEvent();
}

class GetJobListEvent extends GetJobEvent {
  final int page;

  const GetJobListEvent({required this.page});

  @override
  List<Object> get props => [page];
}
