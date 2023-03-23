import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/entities/register_user_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/usecases/register_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/blocs/states/register_state.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

part '../events/register_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase usecase;
  RegisterBloc({required this.usecase}) : super(RegisterInitialState()) {
    on<RegisterUserEvent>((register));
  }
  void register(
    RegisterUserEvent event,
    Emitter<RegisterState> emitter,
  ) async {
    emitter(RegisterLoadingState());

    RegisterEntity registerEntity = RegisterEntity(
      company: event.company,
      email: event.email,
      password: event.password,
    );

    var result = await usecase(registerEntity);

    result.fold(
      (Failure failure) =>
          emitter(RegisterErrorState(message: failure.props.first.toString())),
      (RegisterUserEntity success) =>
          emitter(RegisterSuccessState(registerUser: success)),
    );
  }
}
