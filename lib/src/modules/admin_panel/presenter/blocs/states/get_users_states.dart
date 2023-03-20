import 'package:vagas_flutter_web/src/modules/admin_panel/domain/entities/user_entity.dart';

abstract class GetUsersStates {}

class GetUsersInitialState extends GetUsersStates {}

class GetUsersLoadingState extends GetUsersStates {}

class GetUsersSuccessState extends GetUsersStates {
  final List<UserEntity> listUsers;

  GetUsersSuccessState({required this.listUsers});
}

class GetUsersErrorState extends GetUsersStates {
  final String message;

  GetUsersErrorState({required this.message});
}
