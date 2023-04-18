import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/infra/models/create_company_model.dart';

abstract class CreateCompanyDatasource {
  Future createCompany(CreateCompanyModel companyData);
}
