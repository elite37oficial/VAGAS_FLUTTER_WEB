import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/domain/usecases/get_job_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/blocs/events/get_job_event.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/presenter/blocs/states/get_job_states.dart';
import 'package:vagas_flutter_web/src/shared/helpers/entities/job_entity.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';
import 'package:vagas_flutter_web/src/shared/helpers/generics/usecase.dart';

class GetJobBloc extends Bloc<GetJobEvent, GetJobStates> {
  final GetJobUsecase usecase;
  GetJobBloc({required this.usecase}) : super(GetJobInitialState()) {
    on<GetJobListEvent>(getJob);
  }

  void getJob(
    GetJobEvent event,
    Emitter<GetJobStates> emitter,
  ) async {
    emitter(GetJobLoadingState());

    var result = await usecase(NoParams());

    result.fold(
      (Failure failure) =>
          emitter(GetJobErrorState(message: failure.props.first.toString())),
      (List<JobEntity> success) =>
          emitter(GetJobSuccessState(listJobs: success)),
    );
  }
}
