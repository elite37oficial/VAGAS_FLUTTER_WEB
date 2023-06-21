import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

abstract class AdminGetAllCompaniesStates {}

class AdminGetAllCompaniesStatesInitialState
    extends AdminGetAllCompaniesStates {}

class AdminGetAllCompaniesStatesLoadingState
    extends AdminGetAllCompaniesStates {}

class AdminGetAllCompaniesSuccessState extends AdminGetAllCompaniesStates {
  final List<CompanyEntity> listCompanies;
  AdminGetAllCompaniesSuccessState({required this.listCompanies});
}

class AdminGetAllCompaniesErrorState extends AdminGetAllCompaniesStates {
  final String message;

  AdminGetAllCompaniesErrorState({required this.message});
}
