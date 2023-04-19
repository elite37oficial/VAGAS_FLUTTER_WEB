import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/entities/get_my_self_entity.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/get_my_self_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/events/get_my_self_event.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/states/get_my_self_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class GetMySelfBloc extends Bloc<GetMySelfEvent, GetMySelfStates> {
  final GetMySelfUsecase usecase;
  GetMySelfBloc({required this.usecase}) : super(GetMySelfInitialState()) {
    on<DoGetMySelfEvent>(getMySelf);
  }

  void getMySelf(
    DoGetMySelfEvent event,
    Emitter<GetMySelfStates> emitter,
  ) async {
    emitter(GetMySelfLoadingState());

    GetMySelfEntity getMySelfEntity = GetMySelfEntity(
      email: event.email,
      token: event.token,
    );

    var result = await usecase(getMySelfEntity);

    result.fold(
      (Failure failure) =>
          emitter(GetMySelfErrorState(message: failure.props.first.toString())),
      (bool success) {
        return emitter(GetMySelfSuccessState());
      },
    );
  }
}
