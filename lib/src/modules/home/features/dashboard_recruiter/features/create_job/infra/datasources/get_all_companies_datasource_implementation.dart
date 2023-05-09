import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/get_all_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/models/get_all_companies_response_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetAllCompaniesDatasourceImplementation implements GetAllCompaniesDatasource {
  final AppRequester requester;

  const GetAllCompaniesDatasourceImplementation({required this.requester});

  @override
  Future getAllCompanies() async {
    return await requester.get(
      url: Endpoints.companies,
      fromJson: (value) =>
          GetAllCompaniesResponseModel.fromMap({"listCompanyModels": value}),
    );
  }
}
