import 'package:bloc/bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/get_dashboard_recruiter_usecase_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/presenter/blocs/events/dashboard_recruiter_events.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/presenter/blocs/states/dashboard_recruiter_state.dart';
import 'package:vagas_flutter_web/src/shared/helpers/failures/failures.dart';

class DashboardRecruiterBloc
    extends Bloc<DashboardRecruiterEvent, DashboardRecruiterState> {
  final GetDashboardRecruiterUsecaseImplementation getDashboardRecruiterUsecase;

  DashboardRecruiterBloc({required this.getDashboardRecruiterUsecase})
      : super(DashboardRecruiterInitialState()) {
    on<LoadDashboardRecruiterEvent>(loadListDashboard);
  }

  void loadListDashboard(
    LoadDashboardRecruiterEvent event,
    Emitter<DashboardRecruiterState> emitter,
  ) async {
    emitter(DashboardRecruiterLoadingState());

    var result = await getDashboardRecruiterUsecase();

    result.fold(
        (Failure failure) => emitter(DashboardRecruiterErrorState(
            message: failure.props.first.toString())),
        (list) => list.isEmpty
            ? emitter(DashboardRecruiterEmptyState())
            : emitter(DashboardRecruiterSuccessState(listJobs: list)));
  }
}
