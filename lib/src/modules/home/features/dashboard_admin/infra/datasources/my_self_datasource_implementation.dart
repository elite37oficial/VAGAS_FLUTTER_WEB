import 'package:vagas_flutter_web/src/modules/home/features/dashboard_admin/infra/datasources/my_self_datasource.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/user_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class MySelfDatasourceImplementation implements MySelfDatasource {
  final AppRequester requester;

  MySelfDatasourceImplementation({required this.requester});

  @override
  Future getMySelf(String userId) async {
    return requester.get(
      url: Endpoints.login,
      fromJson: (value) => UserModel.fromMap(value),
    );
  }
}
