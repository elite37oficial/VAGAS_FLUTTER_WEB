import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/get_company_entity.dart';

abstract class GetCompanyStates {}

class GetCompanyInitialState extends GetCompanyStates {}

class GetCompanyLoadingState extends GetCompanyStates {}

class GetCompanySuccessState extends GetCompanyStates {
  final GetCompanyEntity getCompany;

  GetCompanySuccessState({required this.getCompany});
}

class GetCompanyErrorState extends GetCompanyStates {
  final String message;

  GetCompanyErrorState({required this.message});
}
