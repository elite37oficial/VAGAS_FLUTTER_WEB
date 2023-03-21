import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/domain/entities/login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/domain/usecases/login_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/presenter/blocs/events/login_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/login/presenter/blocs/states/login_state.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/user_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase usecase;
  LoginBloc({required this.usecase}) : super(LoginInitialState()) {
    on<DoLoginEvent>(login);
  }

  void login(
    DoLoginEvent event,
    Emitter<LoginState> emitter,
  ) async {
    emitter(LoginLoadingState());

    LoginEntity loginEntity = LoginEntity(
      email: event.email,
      password: event.password,
    );

    var result = await usecase(loginEntity);

    result.fold(
      (Failure failure) =>
          emitter(LoginErrorState(message: failure.props.first.toString())),
      (UserEntity success) => emitter(LoginSuccessState(user: success)),
    );
  }
}
