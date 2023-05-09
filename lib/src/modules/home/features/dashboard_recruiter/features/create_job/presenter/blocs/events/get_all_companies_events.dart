part of '../blocs/get_all_companies_bloc.dart';

abstract class GetAllCompaniesEvent extends Equatable {
  const GetAllCompaniesEvent();
}

class DoGetAllCompaniesEvent extends GetAllCompaniesEvent {
  @override
  List<Object> get props => [];
}
