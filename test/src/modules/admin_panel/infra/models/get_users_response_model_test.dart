import 'package:flutter_test/flutter_test.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/models/get_users_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/user_model.dart';

main() {
  late GetUsersResponseModel usersResponseModel;

  setUp(() {
    usersResponseModel = GetUsersResponseModel(
      listUsers: [
        const UserModel(
          userId: "id",
          username: "name",
          email: "email",
          createdAt: "createdAt",
          listJobs: [],
        ),
      ],
    );
  });

  test("Should return a List<UserModel> from listUsers", () {
    expect(usersResponseModel.listUsers, isA<List<UserModel>>());
  });

  test("Should return a valid List<UserEntity> from a Map", () {
    final Map<String, dynamic> map = {
      "listUsers": [
        {
          "userId": "id",
          "username": "name",
          "email": "email",
          "createdAt": "createdAt",
          "listJobs": [],
        }
      ],
    };

    final result = GetUsersResponseModel.fromMap(map);

    expect(result, isA<GetUsersResponseModel>());
  });

  test("Should return Map containing the GetUsersResponseModel data", () {
    final expectedMap = {
      "listUsers": [
        {
          "userId": "id",
          "username": "name",
          "email": "email",
          "createdAt": "createdAt",
          "listJobs": [],
        }
      ],
    };

    final result = usersResponseModel.toMap();

    expect(result, expectedMap);
  });
}
