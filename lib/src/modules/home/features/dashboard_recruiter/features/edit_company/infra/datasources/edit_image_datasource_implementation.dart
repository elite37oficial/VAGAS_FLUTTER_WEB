import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/datasources/edit_image_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/models/edit_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class EditImageDatasourceImplementation implements EditImageDatasource {
  final AppRequester requester;

  const EditImageDatasourceImplementation({required this.requester});

  @override
  Future editImage(EditImageModel params) async {
    return await requester.post(
      url: Endpoints.companyImage,
      body: params.toMap(),
      fromJson: (value) => EditImageModel.fromMap(value),
    );
  }
}
