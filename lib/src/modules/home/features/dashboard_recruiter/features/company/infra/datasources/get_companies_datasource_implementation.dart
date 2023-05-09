import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/infra/datasources/get_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/infra/models/get_companies_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class GetCompaniesDatasourceImplementation implements GetCompaniesDatasource {
  final AppRequester requester;

  GetCompaniesDatasourceImplementation({required this.requester});

  @override
  Future getCompanies() async {
    return await requester.get(
      url: Endpoints.companies,
      fromJson: (value) =>
          GetCompaniesModel.fromMap({"listCompanyModels": value}),
    );
  }
}
