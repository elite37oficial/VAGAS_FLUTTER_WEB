import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/infra/datasources/change_image_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/infra/models/change_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class ChangeImageDatasourceImplementation implements ChangeImageDatasource {
  final AppRequester requester;

  const ChangeImageDatasourceImplementation({required this.requester});

  @override
  Future changeImage(ChangeImageModel params) async {
    return await requester.post(
      url: Endpoints.companyImage,
      body: params.toMap(),
      fromJson: (value) => ChangeImageModel.fromMap(value),
    );
  }
}
