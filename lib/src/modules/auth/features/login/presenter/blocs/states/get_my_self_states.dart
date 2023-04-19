abstract class GetMySelfStates {}

class GetMySelfInitialState extends GetMySelfStates {}

class GetMySelfLoadingState extends GetMySelfStates {}

class GetMySelfSuccessState extends GetMySelfStates {}

class GetMySelfErrorState extends GetMySelfStates {
  final String message;

  GetMySelfErrorState({required this.message});
}
