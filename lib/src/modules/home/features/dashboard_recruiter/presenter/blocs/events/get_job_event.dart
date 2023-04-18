import 'package:equatable/equatable.dart';

abstract class GetJobEvent extends Equatable {
  const GetJobEvent();
}

class GetJobListEvent extends GetJobEvent {
  @override
  List<Object> get props => [];
}
