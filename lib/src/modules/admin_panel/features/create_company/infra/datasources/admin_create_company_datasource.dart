import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/models/admin_create_company_model.dart';

abstract class AdminCreateCompanyDatasource {
  createCompany(AdminCreateCompanyModel companyData);
}
