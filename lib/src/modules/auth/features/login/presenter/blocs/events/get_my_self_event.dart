part of '../blocs/get_my_self_bloc.dart';

abstract class GetMySelfEvent extends Equatable {
  const GetMySelfEvent();
}

class DoGetMySelfEvent extends GetMySelfEvent {
  final String userId;

  const DoGetMySelfEvent({
    required this.userId,
  });

  @override
  List<String> get props => [userId];
}

class CleanStateGetMySelfEvent extends GetMySelfEvent {
  final GetMySelfState state;

  const CleanStateGetMySelfEvent({
    required this.state,
  });

  @override
  List<GetMySelfState> get props => [state];
}
