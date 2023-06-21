import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/datasources/admin_change_image_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/models/admin_change_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AdminChangeImageDatasourceImplementation
    implements AdminChangeImageDatasource {
  final AppRequester requester;

  const AdminChangeImageDatasourceImplementation({required this.requester});

  @override
  Future changeImage(AdminChangeImageModel params) async {
    return await requester.post(
      url: Endpoints.companyImage,
      body: params.toMap(),
      fromJson: (value) => AdminChangeImageModel.fromMap(value),
    );
  }
}
