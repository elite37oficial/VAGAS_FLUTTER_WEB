import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/decode_token_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/my_self_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/token_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/get_my_self_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/login_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/events/login_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/states/login_state.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  final GetMySelfUsecase getMySelfUsecase;
  LoginBloc({required this.loginUsecase, required this.getMySelfUsecase})
      : super(LoginInitialState()) {
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
      (TokenEntity success) async {
        SecureStorageManager.saveData(StorageKeys.accessToken, success.token);
        await Future.delayed(const Duration(milliseconds: 300));

        DecodedTokenEntity decodedToken =
            DecodedTokenEntity.fromMap(Jwt.parseJwt(success.token));

        SecureStorageManager.saveData(StorageKeys.userId, decodedToken.userID);
      },
    );
    await getMySelf(event, emitter);
  }

  Future<void> getMySelf(
    DoLoginEvent event,
    Emitter<LoginState> emitter,
  ) async {
    emitter(LoginLoadingState());
    String userId =
        await SecureStorageManager.readData(StorageKeys.userId) ?? "";

    var result = await getMySelfUsecase(userId);

    result.fold(
      (Failure failure) =>
          emitter(LoginErrorState(message: failure.props.first.toString())),
      (MySelfEntity success) {
        SecureStorageManager.saveData(StorageKeys.email, success.email);
        SecureStorageManager.saveData(StorageKeys.name, success.name);
        SecureStorageManager.saveData(StorageKeys.phone, success.phone);
        SecureStorageManager.saveData(StorageKeys.role, success.profileId);
        UserRole role = success.profileId == UserRole.recrutador.name
            ? UserRole.recrutador
            : UserRole.admin;
        return emitter(LoginSuccessState(userRole: role));
      },
    );
  }

  Future<void> cleanState(
    CleanStateEvent event,
    Emitter<LoginState> emitter,
  ) async =>
      emitter(LoginInitialState());
}
