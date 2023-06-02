import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/datasources/get_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/models/get_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetCompanyDatasourceImplementation implements GetCompanyDatasource {
  final AppRequester requester;

  const GetCompanyDatasourceImplementation({required this.requester});

  @override
  Future getCompany(String id) async {
    return await requester.get(
      url: Endpoints.getCompanyById(id),
      fromJson: (value) => GetCompanyModel.fromMap(value),
    );
  }
}
