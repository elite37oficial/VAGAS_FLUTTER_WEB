import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/entities/get_users_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/user_model.dart';

class GetUsersResponseModel extends GetUsersResponseEntity {
  final List<UserModel> listUsersModel;

  const GetUsersResponseModel({required this.listUsersModel})
      : super(listUsers: listUsersModel);

  Map<String, dynamic> toMap() {
    return {
      'listUsersModel': listUsersModel.map((x) => x.toMap()).toList(),
    };
  }

  factory GetUsersResponseModel.fromMap(List<dynamic> map) {
    List<UserModel> userList =
        map.map((item) => UserModel.fromMap(item)).toList();
    return GetUsersResponseModel(listUsersModel: userList);
  }
}
