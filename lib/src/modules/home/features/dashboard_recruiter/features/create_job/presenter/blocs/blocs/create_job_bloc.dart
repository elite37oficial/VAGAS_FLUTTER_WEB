import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/create_job_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/entities/create_job_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/usecases/create_job_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/events/create_job_events.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/states/create_job_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class CreateJobBloc extends Bloc<CreateJobEvent, CreateJobStates> {
  final CreateJobUsecase usecase;
  CreateJobBloc({required this.usecase}) : super(CreateJobInitialState()) {
    on<DoCreateJobEvent>(createJob);
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
    );

    var result = await usecase(params);

    result.fold(
      (Failure failure) =>
          emitter(CreateJobErrorState(message: failure.props.first.toString())),
      (CreateJobResponseEntity success) =>
          emitter(CreateJobSuccessState(response: success)),
    );
  }
}
