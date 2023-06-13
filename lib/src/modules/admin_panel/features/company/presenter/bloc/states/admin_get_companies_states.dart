import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/entities/admin_get_companies_entity.dart';

abstract class AdminGetCompaniesStates {}

class AdminGetCompaniesInitialState extends AdminGetCompaniesStates {}

class AdminGetCompaniesLoadingState extends AdminGetCompaniesStates {}

class AdminGetCompaniesSuccessState extends AdminGetCompaniesStates {
  final AdminGetCompaniesEntity listCompanies;

  AdminGetCompaniesSuccessState({required this.listCompanies});
}

class AdminGetCompaniesErrorState extends AdminGetCompaniesStates {
  final String message;

  AdminGetCompaniesErrorState({required this.message});
}
