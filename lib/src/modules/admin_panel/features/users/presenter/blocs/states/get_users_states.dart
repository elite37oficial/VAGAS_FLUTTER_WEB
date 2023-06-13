import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/entities/admin_get_users_response_entity.dart';

abstract class AdminGetUsersStates {}

class AdminGetUsersInitialState extends AdminGetUsersStates {}

class AdminGetUsersLoadingState extends AdminGetUsersStates {}

class AdminGetUsersSuccessState extends AdminGetUsersStates {
  final AdminGetUsersResponseEntity listUsers;

  AdminGetUsersSuccessState({required this.listUsers});
}

class AdminGetUsersErrorState extends AdminGetUsersStates {
  final String message;

  AdminGetUsersErrorState({required this.message});
}
