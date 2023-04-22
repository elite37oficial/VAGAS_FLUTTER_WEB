import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/my_self_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/get_my_self_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/login_bloc.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/storages/secure_storage_manager.dart';
import 'package:vagas_flutter_web/src/shared/storages/storage_keys.dart';

class GetMySelfBloc extends Bloc<LoginEvent, LoginState> {
  final GetMySelfUsecase getMySelfUsecase;
  GetMySelfBloc({required this.getMySelfUsecase}) : super(LoginInitialState()) {
    on<DoGetMySelfEvent>(getMySelf);
    on<CleanStateEvent>(cleanState);
  }


  Future<void> getMySelf(
    LoginEvent event,
    Emitter<LoginState> emitter,
  ) async {
    emitter(GetMySelfStateLoadingState());
    event as DoGetMySelfEvent;
    String userId = event.props.first;

    var result = await getMySelfUsecase(userId);

    result.fold(
      (Failure failure) => emitter(
          GetMySelfStateErrorState(message: failure.props.first.toString())),
      (MySelfEntity success) {
        SecureStorageManager.saveData(StorageKeys.userId, userId);
        SecureStorageManager.saveData(StorageKeys.email, success.email);
        SecureStorageManager.saveData(StorageKeys.name, success.name);
        SecureStorageManager.saveData(StorageKeys.phone, success.phone);
        SecureStorageManager.saveData(StorageKeys.role, success.profileId);
        UserRole role = success.profileId == UserRole.admin.name
            ? UserRole.admin
            : UserRole.recrutador;
        return emitter(GetMySelfStateSuccessState(role: role));
      },
    );
  }

  Future<void> cleanState(
    CleanStateEvent event,
    Emitter<LoginState> emitter,
  ) async =>
      emitter(event.state);
}
