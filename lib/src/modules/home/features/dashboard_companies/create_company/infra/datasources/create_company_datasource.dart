import 'package:vagas_flutter_web/src/modules/home/features/dashboard_companies/create_company/infra/models/create_company_model.dart';

abstract class CreateCompanyDatasource {
  createCompany(CreateCompanyModel companyData);
}
