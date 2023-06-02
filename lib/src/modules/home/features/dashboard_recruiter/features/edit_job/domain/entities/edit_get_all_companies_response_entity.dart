import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

class EditGetAllCompaniesResponseEntity extends Equatable {
  final List<CompanyEntity> listCompanies;

  const EditGetAllCompaniesResponseEntity({required this.listCompanies});

  @override
  List<Object?> get props => [listCompanies];
}
