import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';

class GetUsersResponseEntity extends Equatable {
  final String actualPage;
  final String totalPages;
  final List<UserEntity> listUsers;

  const GetUsersResponseEntity(
      {required this.actualPage,
      required this.totalPages,
      required this.listUsers});

  @override
  List<Object?> get props => [listUsers, actualPage, totalPages];
}
