import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/entities/admin_get_companies_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/company_model.dart';

class AdminGetCompaniesModel extends AdminGetCompaniesEntity {
  final List<CompanyModel> listCompanyModels;

  const AdminGetCompaniesModel(
      {required this.listCompanyModels,
      required super.actualPage,
      required super.totalPages})
      : super(listCompanies: listCompanyModels);

  Map<String, dynamic> toMap() {
    return {
      'listCompanyModels': listCompanyModels.map((x) => x.toMap()).toList(),
      'totalPages': totalPages,
      'actualPages': actualPage,
    };
  }

  factory AdminGetCompaniesModel.fromMap(Map<String, dynamic> map) {
    return AdminGetCompaniesModel(
      listCompanyModels: List<CompanyModel>.from(
          map['data']?.map((x) => CompanyModel.fromMap(x))),
      totalPages: map['totalPages'] ?? '',
      actualPage: map['actualPage'] ?? '',
    );
  }
}
