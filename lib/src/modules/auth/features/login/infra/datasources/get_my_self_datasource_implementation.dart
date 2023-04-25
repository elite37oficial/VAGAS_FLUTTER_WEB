import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/get_my_self_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/models/my_self_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetMySelfDatasourceImplementation implements GetMySelfDatasource {
  final AppRequester requester;

  const GetMySelfDatasourceImplementation({required this.requester});

  @override
  Future getMySelf(String id) async {
    return await requester.get(
      url: Endpoints.getUserById(id),
      fromJson: (value) => MySelfModel.fromMap(value),
    );
  }
}
