import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';

class GetUsersResponseEntity extends Equatable {
  final List<UserEntity> listUsers;

  const GetUsersResponseEntity({required this.listUsers});

  @override
  List<Object?> get props => [listUsers];
}
