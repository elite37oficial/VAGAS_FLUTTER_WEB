import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

class GetCompaniesEntity extends Equatable {
  final String actualPage;
  final String totalPages;
  final List<CompanyEntity> listCompanies;

  const GetCompaniesEntity({
    required this.actualPage,
    required this.totalPages,
    required this.listCompanies,
  });

  @override
  List<Object?> get props => [actualPage, totalPages, listCompanies];
}
