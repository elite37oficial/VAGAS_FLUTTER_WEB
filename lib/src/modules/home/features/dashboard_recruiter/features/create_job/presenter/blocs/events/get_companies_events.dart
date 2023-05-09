part of "../blocs/get_companies_bloc.dart";

abstract class GetCompaniesEvent extends Equatable {
  const GetCompaniesEvent();
}

class DoGetCompaniesEvent extends GetCompaniesEvent {
  @override
  List<Object> get props => [];
}
