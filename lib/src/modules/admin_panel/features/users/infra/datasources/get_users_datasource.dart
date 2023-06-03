import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/models/get_users_response_model.dart';

abstract class GetUsersDatasource {
  Future<GetUsersResponseModel> getUsers();
}
