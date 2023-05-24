import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/entities/edit_job_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/usecases/edit_job_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

part '../events/edit_job_events.dart';
part '../states/edit_job_states.dart';

class EditJobBloc extends Bloc<EditJobEvent, EditJobStates> {
  final EditJobUsecase usecase;
  EditJobBloc({required this.usecase}) : super(EditJobInitialState()) {
    on<DoEditJobEvent>(editJob);
    on<CleanStateEvent>(cleanState);
  }

  void editJob(
    DoEditJobEvent event,
    Emitter<EditJobStates> emitter,
  ) async {
    emitter(EditJobLoadingState());

    EditJobEntity params = EditJobEntity(
      id: event.id,
      status: event.status,
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
      (Failure failure) =>
          emitter(EditJobErrorState(message: failure.props.first.toString())),
      (bool success) => emitter(EditJobSuccessState(response: success)),
    );
  }

  Future<void> cleanState(
    CleanStateEvent event,
    Emitter<EditJobStates> emitter,
  ) async =>
      emitter(event.state);
}
