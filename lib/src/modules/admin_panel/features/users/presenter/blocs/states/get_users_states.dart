import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/entities/get_users_response_entity.dart';

abstract class GetUsersStates {}

class GetUsersInitialState extends GetUsersStates {}

class GetUsersLoadingState extends GetUsersStates {}

class GetUsersSuccessState extends GetUsersStates {
  final GetUsersResponseEntity listUsers;

  GetUsersSuccessState({required this.listUsers});
}

class GetUsersErrorState extends GetUsersStates {
  final String message;

  GetUsersErrorState({required this.message});
}
