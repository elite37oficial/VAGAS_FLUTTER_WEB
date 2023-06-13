import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/datasources/admin_get_users_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/models/admin_get_users_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AdminGetUsersDatasourceImplementation implements AdminGetUsersDatasource {
  final AppRequester requester;

  AdminGetUsersDatasourceImplementation({required this.requester});

  @override
  Future adminGetUsers(int page) async {
    return await requester.get(
      url: Endpoints.pageUsersAdmin(page),
      fromJson: (value) => AdminGetUsersResponseModel.fromMap(value),
    );
  }
}
