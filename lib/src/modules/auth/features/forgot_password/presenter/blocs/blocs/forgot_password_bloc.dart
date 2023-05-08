import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/domain/usecases/forgot_password_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

part '../events/forgot_password_events.dart';
part '../states/forgot_password_states.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordStates> {
  final ForgotPasswordUsecase forgotPasswordUsecase;
  ForgotPasswordBloc({required this.forgotPasswordUsecase})
      : super(ForgotPasswordInitialState()) {
    on<DoForgotPasswordEvent>(forgotPassword);
    on<CleanStateEvent>(cleanState);
  }

  Future<void> forgotPassword(
    DoForgotPasswordEvent event,
    Emitter<ForgotPasswordStates> emitter,
  ) async {
    emitter(ForgotPasswordLoadingState());

    var result = await forgotPasswordUsecase(event.email);

    result.fold(
      (Failure failure) => emitter(
          ForgotPasswordErrorState(message: failure.props.first.toString())),
      (String success) => emitter(ForgotPasswordSuccessState(message: success)),
    );
  }

  Future<void> cleanState(
    CleanStateEvent event,
    Emitter<ForgotPasswordStates> emitter,
  ) async =>
      emitter(event.state);
}
