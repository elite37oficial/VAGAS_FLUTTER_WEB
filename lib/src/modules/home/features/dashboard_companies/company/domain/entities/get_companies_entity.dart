import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

class GetCompaniesEntity extends Equatable {
  final List<CompanyEntity> listCompanies;

  const GetCompaniesEntity({required this.listCompanies});

  @override
  List<Object?> get props => [listCompanies];
}
