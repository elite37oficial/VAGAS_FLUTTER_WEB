import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_company_entity.dart';

abstract class EditCompanyStates {}

class EditCompanyInitialState extends EditCompanyStates {}

class EditCompanyLoadingState extends EditCompanyStates {}

class EditCompanySuccessState extends EditCompanyStates {
  final bool editCompany;

  EditCompanySuccessState({required this.editCompany});
}

class EditCompanyErrorState extends EditCompanyStates {
  final String message;

  EditCompanyErrorState({required this.message});
}
