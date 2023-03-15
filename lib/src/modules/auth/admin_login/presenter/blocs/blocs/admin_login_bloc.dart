import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_login_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/entities/admin_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/domain/usecases/admin_login_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/events/admin_login_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/admin_login/presenter/blocs/states/admin_login_state.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  final AdminLoginUsecase usecase;
  AdminLoginBloc({required this.usecase}) : super(AdminLoginInitialState()) {
    on<LoginEvent>(login);
  }

  void login(
    LoginEvent event,
    Emitter<AdminLoginState> emitter,
  ) async {
    emitter(AdminLoginLoadingState());

    AdminLoginEntity loginEntity = AdminLoginEntity(
      email: event.email,
      password: event.password,
    );

    var result = await usecase(loginEntity);

    result.fold(
      (Failure failure) => emitter(
          AdminLoginErrorState(message: failure.props.first.toString())),
      (AdminUserEntity success) =>
          emitter(AdminLoginSuccessState(adminUser: success)),
    );
  }
}
