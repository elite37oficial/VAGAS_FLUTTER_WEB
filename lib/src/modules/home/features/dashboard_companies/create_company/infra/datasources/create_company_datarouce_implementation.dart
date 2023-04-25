import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/datasources/create_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/models/create_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/company_model.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class CreateCompanyDatasourceImplementation implements CreateCompanyDatasource {
  final AppRequester requester;

  CreateCompanyDatasourceImplementation({required this.requester});

  @override
  Future createCompany(CreateCompanyModel companyData) async {
    return await requester.post(
      url: Endpoints.companies,
      body: companyData.toMap(),
      fromJson: (value) => CompanyModel.fromMap(value),
    );
  }
}
