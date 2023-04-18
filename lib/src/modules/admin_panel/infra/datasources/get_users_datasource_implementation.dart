import 'package:vagas_flutter_web/src/modules/admin_panel/infra/datasources/get_users_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/infra/models/get_users_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetUsersDatasourceImplementation implements GetUsersDatasource {
  final AppRequester requester;

  GetUsersDatasourceImplementation({required this.requester});

  @override
  Future getUsers() async {
    return await requester.get(
      url: Endpoints.users,
      fromJson: (value) => GetUsersResponseModel.fromMap(value),
    );
  }
}
