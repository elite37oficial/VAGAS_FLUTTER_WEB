import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/datasources/admin_create_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/models/admin_create_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AdminCreateCompanyDatasourceImplementation
    implements AdminCreateCompanyDatasource {
  final AppRequester requester;

  AdminCreateCompanyDatasourceImplementation({required this.requester});

  @override
  Future<AdminCreateCompanyModel> createCompany(
      AdminCreateCompanyModel companyData) async {
    return await requester.post(
      url: Endpoints.companies,
      body: companyData.toMap(),
      fromJson: (value) {
        return AdminCreateCompanyModel(
          id: value["id"] as String,
          name: companyData.name,
          location: companyData.location,
          description: companyData.description,
        );
      },
    );
  }
}
