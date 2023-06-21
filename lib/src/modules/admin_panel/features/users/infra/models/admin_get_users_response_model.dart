import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/entities/admin_get_users_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/user_model.dart';

class AdminGetUsersResponseModel extends AdminGetUsersResponseEntity {
  final List<UserModel> listUsersModel;

  const AdminGetUsersResponseModel(
      {required this.listUsersModel,
      required super.actualPage,
      required super.totalPages})
      : super(listUsers: listUsersModel);

  Map<String, dynamic> toMap() {
    return {
      'listUsersModel': listUsersModel.map((x) => x.toMap()).toList(),
      'totalPages': totalPages,
      'actualPages': actualPage,
    };
  }

  factory AdminGetUsersResponseModel.fromMap(Map<String, dynamic> map) {
    return AdminGetUsersResponseModel(
      listUsersModel:
          List<UserModel>.from(map['data']?.map((x) => UserModel.fromMap(x))),
      totalPages: map['totalPages'] ?? '',
      actualPage: map['actualPage'] ?? '',
    );
  }
}