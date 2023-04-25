import 'package:vagas_flutter_web/src/shared/helpers/entities/company_entity.dart';

abstract class CreateCompanyStates {}

class CreateCompanyInitialState extends CreateCompanyStates {}

class CreateCompanyLoadingState extends CreateCompanyStates {}

class CreateCompanySuccessState extends CreateCompanyStates {
  final CompanyEntity company;

  CreateCompanySuccessState({required this.company});
}

class CreateCompanyErrorState extends CreateCompanyStates {
  final String message;

  CreateCompanyErrorState({required this.message});
}
