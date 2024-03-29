part of "../bloc/get_companies_bloc.dart";

abstract class GetCompaniesStates {}

class GetCompaniesInitialState extends GetCompaniesStates {}

class GetCompaniesLoadingState extends GetCompaniesStates {}

class GetCompaniesSuccessState extends GetCompaniesStates {
  final GetCompaniesEntity listCompanies;

  GetCompaniesSuccessState({required this.listCompanies});
}

class GetCompaniesErrorState extends GetCompaniesStates {
  final String message;

  GetCompaniesErrorState({required this.message});
}
