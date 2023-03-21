import 'package:vagas_flutter_web/src/shared/helpers/models/user_model.dart';

class GetUsersResponseModel {
  final List<UserModel> listUsers;

  GetUsersResponseModel({required this.listUsers});

  Map<String, dynamic> toMap() {
    return {
      'listUsers': listUsers.map((x) => x.toMap()).toList(),
    };
  }

  factory GetUsersResponseModel.fromMap(Map<String, dynamic> map) {
    return GetUsersResponseModel(
      listUsers: List<UserModel>.from(
          map['listUsers']?.map((x) => UserModel.fromMap(x))),
    );
  }
}
