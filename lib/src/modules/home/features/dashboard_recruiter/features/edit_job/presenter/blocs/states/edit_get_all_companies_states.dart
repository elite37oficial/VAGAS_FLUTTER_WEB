part of '../blocs/edit_get_all_companies_bloc.dart';

abstract class EditGetAllCompaniesStates {}

class EditGetAllCompaniesStatesInitialState extends EditGetAllCompaniesStates {}

class EditGetAllCompaniesStatesLoadingState extends EditGetAllCompaniesStates {}

class EditGetAllCompaniesSuccessState extends EditGetAllCompaniesStates {
  final List<CompanyEntity> listCompanies;
  EditGetAllCompaniesSuccessState({required this.listCompanies});
}

class EditGetAllCompaniesErrorState extends EditGetAllCompaniesStates {
  final String message;

  EditGetAllCompaniesErrorState({required this.message});
}
