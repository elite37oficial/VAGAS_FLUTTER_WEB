import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/usecases/get_job_by_id_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

part '../events/get_job_by_id_events.dart';
part '../states/get_job_by_id_states.dart';

class GetJobByIdBloc extends Bloc<GetJobByIdEvent, GetJobByIdStates> {
  final GetJobByIdUsecase usecase;
  GetJobByIdBloc({required this.usecase}) : super(GetJobByIdInitialState()) {
    on<DoGetJobByIdEvent>(getJobById);
    on<CleanGetJobByIdStateEvent>(cleanState);
  }

  void getJobById(
    DoGetJobByIdEvent event,
    Emitter<GetJobByIdStates> emitter,
  ) async {
    emitter(GetJobByIdLoadingState());

    var result = await usecase(event.jobId);

    result.fold(
      (Failure failure) =>
          emitter(GetJobByIdErrorState(message: failure.props.first.toString())),
      (JobEntity success) => emitter(GetJobByIdSuccessState(response: success)),
    );
  }

  Future<void> cleanState(
    CleanGetJobByIdStateEvent event,
    Emitter<GetJobByIdStates> emitter,
  ) async =>
      emitter(event.state);
}
