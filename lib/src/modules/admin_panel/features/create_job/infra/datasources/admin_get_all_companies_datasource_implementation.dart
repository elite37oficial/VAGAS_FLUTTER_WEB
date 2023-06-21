import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/datasources/admin_get_all_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/models/admin_get_all_companies_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AdminGetAllCompaniesDatasourceImplementation
    implements AdminGetAllCompaniesDatasource {
  final AppRequester requester;

  const AdminGetAllCompaniesDatasourceImplementation({required this.requester});

  @override
  Future getAllCompanies() async {
    return await requester.get(
      url: Endpoints.companies,
      fromJson: (value) => AdminGetAllCompaniesResponseModel.fromMap(
          {"listCompanyModels": value}),
    );
  }
}
