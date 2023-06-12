import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/entities/admin_get_job_response_entity.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/usecases/admin_get_job_usecase.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

part '../events/get_job_event.dart';
part '../states/get_job_states.dart';

class AdminGetJobBloc extends Bloc<AdminGetJobEvent, AdminGetJobStates> {
  final AdminGetJobUsecase usecase;
  AdminGetJobBloc({required this.usecase}) : super(AdminGetJobInitialState()) {
    on<AdminGetJobListEvent>(adminGetJob);
    on<CleanAdminGetJobStateEvent>(cleanState);
  }

  void adminGetJob(
    AdminGetJobListEvent event,
    Emitter<AdminGetJobStates> emitter,
  ) async {
    emitter(AdminGetJobLoadingState());

    var result = await usecase(event.page);

    result.fold(
      (Failure failure) => emitter(
          AdminGetJobErrorState(message: failure.props.first.toString())),
      (AdminGetJobResponseEntity success) =>
          emitter(AdminGetJobSuccessState(listJobs: success)),
    );
  }

  Future<void> cleanState(
    CleanAdminGetJobStateEvent event,
    Emitter<AdminGetJobStates> emitter,
  ) async =>
      emitter(event.state);
}
