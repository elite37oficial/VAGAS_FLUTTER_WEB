import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/states/login_state.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class DoLoginEvent extends LoginEvent {
  final String email;
  final String password;

  const DoLoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class GetMySelfEvent extends LoginEvent {
  final String userId;

  const GetMySelfEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}

class CleanStateEvent extends LoginEvent {
  final LoginState state;

  const CleanStateEvent({
    required this.state,
  });

  @override
  List<LoginState> get props => [state];
}
