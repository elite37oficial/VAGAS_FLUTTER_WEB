import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

class AdminGetAllCompaniesResponseEntity extends Equatable {
  final List<CompanyEntity> listCompanies;

  const AdminGetAllCompaniesResponseEntity({required this.listCompanies});

  @override
  List<Object?> get props => [listCompanies];
}
