import 'package:equatable/equatable.dart';

abstract class GetUsersEvent extends Equatable {
  const GetUsersEvent();
}

class GetEvent extends GetUsersEvent {
  @override
  List<Object> get props => [];
}
