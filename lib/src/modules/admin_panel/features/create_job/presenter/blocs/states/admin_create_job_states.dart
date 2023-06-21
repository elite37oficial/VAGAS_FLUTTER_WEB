abstract class AdminCreateJobStates {}

class AdminCreateJobInitialState extends AdminCreateJobStates {}

class AdminCreateJobLoadingState extends AdminCreateJobStates {}

class AdminCreateJobSuccessState extends AdminCreateJobStates {
  final bool response;

  AdminCreateJobSuccessState({required this.response});
}

class AdminCreateJobErrorState extends AdminCreateJobStates {
  final String message;

  AdminCreateJobErrorState({required this.message});
}
