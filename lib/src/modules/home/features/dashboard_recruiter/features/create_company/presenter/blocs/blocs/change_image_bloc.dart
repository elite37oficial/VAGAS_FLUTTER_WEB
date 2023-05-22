import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/entities/change_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/domain/usecases/change_image_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/blocs/events/change_image_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/presenter/blocs/states/change_image_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class ChangeImageBloc extends Bloc<ChangeImageEvent, ChangeImageStates> {
  final ChangeImageUsecase usecase;
  ChangeImageBloc({required this.usecase}) : super(ChangeImageInitialState()) {
    on<DoChangeImageEvent>(changeImage);
  }

  void changeImage(
    DoChangeImageEvent event,
    Emitter<ChangeImageStates> emitter,
  ) async {
    emitter(ChangeImageLoadingState());

    ChangeImageEntity params = ChangeImageEntity(
      companyId: event.companyId,
      image64: event.image64,
    );
    var result = await usecase(params);

    result.fold(
      (Failure failure) => emitter(
          ChangeImageErrorState(message: failure.props.first.toString())),
      (ChangeImageEntity success) =>
          emitter(ChangeImageSuccessState(response: success)),
    );
  }
}
