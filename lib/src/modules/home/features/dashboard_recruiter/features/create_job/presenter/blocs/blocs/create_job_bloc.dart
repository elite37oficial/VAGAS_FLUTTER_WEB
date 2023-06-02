import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/create_job_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/usecases/create_job_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

part '../events/create_job_events.dart';
part '../states/create_job_states.dart';

class CreateJobBloc extends Bloc<CreateJobEvent, CreateJobStates> {
  final CreateJobUsecase usecase;
  CreateJobBloc({required this.usecase}) : super(CreateJobInitialState()) {
    on<DoCreateJobEvent>(createJob);
    on<CleanStateEvent>(cleanState);
  }

  void createJob(
    DoCreateJobEvent event,
    Emitter<CreateJobStates> emitter,
  ) async {
    emitter(CreateJobLoadingState());

    CreateJobEntity params = CreateJobEntity(
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
          emitter(CreateJobErrorState(message: failure.props.first.toString())),
      (bool success) => emitter(CreateJobSuccessState(response: success)),
    );
  }

  Future<void> cleanState(
    CleanStateEvent event,
    Emitter<CreateJobStates> emitter,
  ) async =>
      emitter(event.state);
}
