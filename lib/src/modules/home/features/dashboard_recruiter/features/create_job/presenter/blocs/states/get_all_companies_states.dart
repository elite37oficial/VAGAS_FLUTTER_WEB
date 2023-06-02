part of '../blocs/get_all_companies_bloc.dart';

abstract class GetAllCompaniesStates {}

class GetAllCompaniesStatesInitialState extends GetAllCompaniesStates {}

class GetAllCompaniesStatesLoadingState extends GetAllCompaniesStates {}

class GetAllCompaniesSuccessState extends GetAllCompaniesStates {
  final List<CompanyEntity> listCompanies;
  GetAllCompaniesSuccessState({required this.listCompanies});
}

class GetAllCompaniesErrorState extends GetAllCompaniesStates {
  final String message;

  GetAllCompaniesErrorState({required this.message});
}
