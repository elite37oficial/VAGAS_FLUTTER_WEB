import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/entities/edit_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/domain/usecases/edit_image_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/blocs/events/edit_image_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_company/presenter/blocs/states/edit_image_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class EditImageBloc extends Bloc<EditImageEvent, EditImageStates> {
  final EditImageUsecase usecase;
  EditImageBloc({required this.usecase}) : super(EditImageInitialState()) {
    on<DoEditImageEvent>(editImage);
  }

  void editImage(
    DoEditImageEvent event,
    Emitter<EditImageStates> emitter,
  ) async {
    emitter(EditImageLoadingState());

    EditImageEntity params = EditImageEntity(
      companyId: event.companyId,
      image64: event.image64,
    );
    var result = await usecase(params);

    result.fold(
      (Failure failure) =>
          emitter(EditImageErrorState(message: failure.props.first.toString())),
      (EditImageEntity success) =>
          emitter(EditImageSuccessState(response: success)),
    );
  }
}
