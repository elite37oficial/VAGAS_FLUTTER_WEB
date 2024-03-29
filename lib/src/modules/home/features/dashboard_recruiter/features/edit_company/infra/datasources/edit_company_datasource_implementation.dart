import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/datasources/edit_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/infra/models/edit_company_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class EditCompanyDatasourceImplementation implements EditCompanyDatasource {
  final AppRequester requester;

  EditCompanyDatasourceImplementation({required this.requester});

  @override
  Future editCompany(EditCompanyModel companyData) async {
    return await requester.put(
      url: Endpoints.companies,
      body: companyData.toMap(),
      fromJson: (value) {},
    );
  }
}
