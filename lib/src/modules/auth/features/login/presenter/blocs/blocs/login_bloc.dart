import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/decode_token_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/my_self_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/token_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/get_my_self_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/login_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

part '../events/login_event.dart';
part '../states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc({required this.loginUsecase}) : super(LoginInitialState()) {
    on<DoLoginEvent>(login);
    on<CleanStateEvent>(cleanState);
  }

  Future<void> login(
    DoLoginEvent event,
    Emitter<LoginState> emitter,
  ) async {
    emitter(LoginLoadingState());

    LoginEntity loginEntity = LoginEntity(
      email: event.email,
      password: event.password,
    );

    var result = await loginUsecase(loginEntity);

    result.fold(
      (Failure failure) =>
          emitter(LoginErrorState(message: failure.props.first.toString())),
      (TokenEntity success) {
        var res = JWT.decode(success.token);

        SecureStorageManager.saveData(StorageKeys.accessToken, success.token);

        DecodedTokenEntity decodedToken =
            DecodedTokenEntity.fromMap(res.payload);

        return emitter(LoginSuccessState(userId: decodedToken.userID));
      },
    );
  }

  Future<void> cleanState(
    CleanStateEvent event,
    Emitter<LoginState> emitter,
  ) async =>
      emitter(event.state);
}
