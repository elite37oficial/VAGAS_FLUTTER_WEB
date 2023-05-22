abstract class EditCompanyStates {}

class EditCompanyInitialState extends EditCompanyStates {}

class EditCompanyLoadingState extends EditCompanyStates {}

class EditCompanySuccessState extends EditCompanyStates {
  final bool editCompany;

  EditCompanySuccessState({required this.editCompany});
}

class EditCompanyErrorState extends EditCompanyStates {
  final String message;

  EditCompanyErrorState({required this.message});
}
