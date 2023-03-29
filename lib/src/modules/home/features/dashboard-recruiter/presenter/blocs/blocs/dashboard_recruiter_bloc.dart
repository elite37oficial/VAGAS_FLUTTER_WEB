// import 'package:bloc/bloc.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/entities/dashboard_recruiter_entity.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/dashboard_recruiter_usecase.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/presenter/blocs/events/dashboard_recruiter_events.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/presenter/blocs/states/dashboard_recruiter_state.dart';

// class DashboardRecruiterBloc
//     extends Bloc<DashboardRecruiterEvent, DashboardRecruiterState> {
//   final GetDashboardRecruiterUseCase _usecase;

//   DashboardRecruiterBloc({required GetDashboardRecruiterUseCase usecase})
//       : _usecase = usecase,
//         super(ListJobsDashboardRecruiterState(listJobs: []));

//   Stream<DashboardRecruiterState> mapEventToState(
//       DashboardRecruiterEvent event) async* {
//     if (event is GetDashboardRecruiterEvent) {
//       yield LoadingDashboardRecruiterState();

//       try {
//         List<DashboardRecruiterEntity> listJobs = await _usecase();
//         if (listJobs.isEmpty) {
//           yield EmptyDashboardRecruiterState();
//         } else {
//           yield ListJobsDashboardRecruiterState(listJobs: listJobs);
//         }
//       } catch (e) {
//         yield ErrorDashboardRecruiterState(e.toString());
//       }
//     }
//   }
// }
