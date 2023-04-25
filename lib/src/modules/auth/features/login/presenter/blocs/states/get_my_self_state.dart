part of '../blocs/get_my_self_bloc.dart';

enum UserRole { recrutador, admin }

abstract class GetMySelfState {}

class GetMySelfStateInitialState extends GetMySelfState {}

class GetMySelfStateLoadingState extends GetMySelfState {}

class GetMySelfStateSuccessState extends GetMySelfState {
  final UserRole role;

  GetMySelfStateSuccessState({required this.role});
}

class GetMySelfStateErrorState extends GetMySelfState {
  final String message;

  GetMySelfStateErrorState({required this.message});
}
