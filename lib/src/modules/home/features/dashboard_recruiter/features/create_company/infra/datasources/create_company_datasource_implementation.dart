import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/infra/datasources/create_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/infra/models/create_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class CreateCompanyDatasourceImplementation implements CreateCompanyDatasource {
  final AppRequester requester;

  CreateCompanyDatasourceImplementation({required this.requester});

  @override
  Future<CreateCompanyModel> createCompany(
      CreateCompanyModel companyData) async {
    return await requester.post(
      url: Endpoints.companies,
      body: companyData.toMap(),
      fromJson: (value) {
        return CreateCompanyModel(
          id: value["id"] as String,
          name: companyData.name,
          location: companyData.location,
          description: companyData.description,
        );
      },
    );
  }
}
