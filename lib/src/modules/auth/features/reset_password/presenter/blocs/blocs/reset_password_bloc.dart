import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/domain/usecases/reset_password_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

part '../events/reset_password_events.dart';
part '../states/reset_password_states.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordStates> {
  final ResetPasswordUsecase resetPasswordUsecase;
  ResetPasswordBloc({required this.resetPasswordUsecase})
      : super(ResetPasswordInitialState()) {
    on<DoResetPasswordEvent>(resetPassword);
    on<CleanStateEvent>(cleanState);
  }

  Future<void> resetPassword(
    DoResetPasswordEvent event,
    Emitter<ResetPasswordStates> emitter,
  ) async {
    emitter(ResetPasswordLoadingState());

    var result = await resetPasswordUsecase(event.email);

    result.fold(
      (Failure failure) => emitter(
          ResetPasswordErrorState(message: failure.props.first.toString())),
      (String success) => emitter(ResetPasswordSuccessState(message: success)),
    );
  }

  Future<void> cleanState(
    CleanStateEvent event,
    Emitter<ResetPasswordStates> emitter,
  ) async =>
      emitter(event.state);
}
