import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/infra/datasources/admin_get_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/infra/models/admin_get_companies_model.dart';
import 'package:vagas_flutter_web/src/shared/helpers/endpoints/endpoints.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester.dart';

class AdminGetCompaniesDatasourceImplementation
    implements AdminGetCompaniesDatasource {
  final AppRequester requester;

  AdminGetCompaniesDatasourceImplementation({required this.requester});

  @override
  Future adminGetCompanies(int page) async {
    return await requester.get(
      url: Endpoints.pageCompanies(page),
      fromJson: (value) => AdminGetCompaniesModel.fromMap(value),
    );
  }
}
