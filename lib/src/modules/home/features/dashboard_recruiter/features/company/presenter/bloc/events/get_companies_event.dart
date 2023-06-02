part of "../bloc/get_companies_bloc.dart";

abstract class GetCompaniesEvent extends Equatable {
  const GetCompaniesEvent();
}

class GetCompaniesListEvent extends GetCompaniesEvent {
  final int page;

  const GetCompaniesListEvent({required this.page});

  @override
  List<Object> get props => [page];
}
