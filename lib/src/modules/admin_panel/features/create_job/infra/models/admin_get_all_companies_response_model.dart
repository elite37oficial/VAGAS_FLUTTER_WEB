import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/entities/admin_get_all_companies_response_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/company_model.dart';

class AdminGetAllCompaniesResponseModel
    extends AdminGetAllCompaniesResponseEntity {
  final List<CompanyModel> listCompanyModels;

  const AdminGetAllCompaniesResponseModel({required this.listCompanyModels})
      : super(listCompanies: listCompanyModels);

  Map<String, dynamic> toMap() {
    return {
      'listCompanyModels': listCompanyModels.map((x) => x.toMap()).toList(),
    };
  }

  factory AdminGetAllCompaniesResponseModel.fromMap(Map<String, dynamic> map) {
    return AdminGetAllCompaniesResponseModel(
      listCompanyModels: List<CompanyModel>.from(
          map['listCompanyModels']?.map((x) => CompanyModel.fromMap(x))),
    );
  }
}
