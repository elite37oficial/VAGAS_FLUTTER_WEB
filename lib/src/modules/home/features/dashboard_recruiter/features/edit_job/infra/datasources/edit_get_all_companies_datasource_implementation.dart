import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/edit_get_all_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/models/edit_get_all_companies_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class EditGetAllCompaniesDatasourceImplementation
    implements EditGetAllCompaniesDatasource {
  final AppRequester requester;

  const EditGetAllCompaniesDatasourceImplementation({required this.requester});

  @override
  Future getAllCompanies() async {
    return await requester.get(
      url: Endpoints.companies,
      fromJson: (value) => EditGetAllCompaniesResponseModel.fromMap(
          {"listCompanyModels": value}),
    );
  }
}
