import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/infra/datasources/get_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/infra/models/get_company_image_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetCompanyImageDatasourceImplementation
    implements GetCompanyImageDatasource {
  final AppRequester requester;

  GetCompanyImageDatasourceImplementation({required this.requester});

  @override
  Future getCompanyImage() async {
    String id = '';
    return await requester.get(
      url: Endpoints.getCompanyImageById(id),
      fromJson: (value) => GetCompanyImageModel.fromMap(value),
    );
  }
}
