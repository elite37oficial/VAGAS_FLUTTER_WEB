import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/entities/create_company_entity.dart';

abstract class CreateCompanyStates {}

class CreateCompanyInitialState extends CreateCompanyStates {}

class CreateCompanyLoadingState extends CreateCompanyStates {}

class CreateCompanySuccessState extends CreateCompanyStates {
  final CreateCompanyEntity company;

  CreateCompanySuccessState({required this.company});
}

class CreateCompanyErrorState extends CreateCompanyStates {
  final String message;

  CreateCompanyErrorState({required this.message});
}
