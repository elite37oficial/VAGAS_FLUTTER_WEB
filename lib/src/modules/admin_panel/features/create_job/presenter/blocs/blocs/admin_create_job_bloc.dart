import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/entities/admin_create_job_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/usecases/admin_create_job_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/blocs/events/admin_create_job_events.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/blocs/states/admin_create_job_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class AdminCreateJobBloc
    extends Bloc<AdminCreateJobEvent, AdminCreateJobStates> {
  final AdminCreateJobUsecase usecase;
  AdminCreateJobBloc({required this.usecase})
      : super(AdminCreateJobInitialState()) {
    on<DoAdminCreateJobEvent>(createJob);
    on<CleanStateEvent>(cleanState);
  }

  void createJob(
    DoAdminCreateJobEvent event,
    Emitter<AdminCreateJobStates> emitter,
  ) async {
    emitter(AdminCreateJobLoadingState());

    AdminCreateJobEntity params = AdminCreateJobEntity(
      title: event.title,
      description: event.description,
      companyId: event.companyId,
      userId: event.userId,
      email: event.email,
      level: event.level,
      link: event.link,
      phone: event.phone,
      type: event.type,
      city: event.city,
      companyDescription: event.companyDescription,
      modality: event.modality,
      salary: event.salary,
      state: event.state,
    );

    var result = await usecase(params);

    result.fold(
      (Failure failure) => emitter(
          AdminCreateJobErrorState(message: failure.props.first.toString())),
      (bool success) => emitter(AdminCreateJobSuccessState(response: success)),
    );
  }

  Future<void> cleanState(
    CleanStateEvent event,
    Emitter<AdminCreateJobStates> emitter,
  ) async =>
      emitter(event.state);
}
