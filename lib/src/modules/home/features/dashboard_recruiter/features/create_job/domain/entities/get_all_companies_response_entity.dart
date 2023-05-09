import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

class GetAllCompaniesResponseEntity extends Equatable {
  final List<CompanyEntity> listCompanies;

  const GetAllCompaniesResponseEntity({required this.listCompanies});

  @override
  List<Object?> get props => [listCompanies];
}
