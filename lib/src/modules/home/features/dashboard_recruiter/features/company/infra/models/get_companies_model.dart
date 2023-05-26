import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/entities/get_companies_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/models/company_model.dart';

class GetCompaniesModel extends GetCompaniesEntity {
  final List<CompanyModel> listCompanyModels;

  const GetCompaniesModel(
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

  factory GetCompaniesModel.fromMap(Map<String, dynamic> map) {
    return GetCompaniesModel(
      listCompanyModels: List<CompanyModel>.from(
          map['data']?.map((x) => CompanyModel.fromMap(x))),
      totalPages: map['totalPages'] ?? '',
      actualPage: map['actualPage'] ?? '',
    );
  }
}
