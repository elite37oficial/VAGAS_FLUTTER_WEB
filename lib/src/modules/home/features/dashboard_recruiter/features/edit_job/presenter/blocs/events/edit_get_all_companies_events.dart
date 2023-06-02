part of "../blocs/edit_get_all_companies_bloc.dart";

abstract class EditGetAllCompaniesEvent extends Equatable {
  const EditGetAllCompaniesEvent();
}

class DoEditGetAllCompaniesEvent extends EditGetAllCompaniesEvent {
  @override
  List<Object> get props => [];
}
