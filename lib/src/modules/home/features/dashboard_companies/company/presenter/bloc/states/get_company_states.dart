import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

abstract class GetCompanyStates {}

class GetCompanyInitialState extends GetCompanyStates {}

class GetCompanyLoadingState extends GetCompanyStates {}

class GetCompanySuccessState extends GetCompanyStates {
  final List<CompanyEntity> listCompanies;

  GetCompanySuccessState({required this.listCompanies});
}

class GetCompanyErrorState extends GetCompanyStates {
  final String message;

  GetCompanyErrorState({required this.message});
}
