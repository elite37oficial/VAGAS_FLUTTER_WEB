import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/entities/admin_change_image_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/usecases/admin_change_image_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/events/admin_change_image_event.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/states/admin_change_image_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminChangeImageBloc
    extends Bloc<AdminChangeImageEvent, AdminChangeImageStates> {
  final AdminChangeImageUsecase usecase;
  AdminChangeImageBloc({required this.usecase})
      : super(AdminChangeImageInitialState()) {
    on<DoAdminChangeImageEvent>(changeImage);
  }

  void changeImage(
    DoAdminChangeImageEvent event,
    Emitter<AdminChangeImageStates> emitter,
  ) async {
    emitter(AdminChangeImageLoadingState());

    AdminChangeImageEntity params = AdminChangeImageEntity(
      companyId: event.companyId,
      image64: event.image64,
    );
    var result = await usecase(params);

    result.fold(
      (Failure failure) => emitter(
          AdminChangeImageErrorState(message: failure.props.first.toString())),
      (AdminChangeImageEntity success) =>
          emitter(AdminChangeImageSuccessState(response: success)),
    );
  }
}
