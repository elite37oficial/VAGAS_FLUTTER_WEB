// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/dashboard_recruiter_usecase.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/domain/usecases/get_dashboard_recruiter_usecase.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/datasources/dashboard_recruiter_datasource_implementation.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/infra/repositories/dashboard_recruiter_repository_implementation_.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/presenter/blocs/blocs/dashboard_recruiter_bloc.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/presenter/blocs/events/dashboard_recruiter_events.dart';
// import 'package:vagas_flutter_web/src/modules/home/features/dashboard-recruiter/presenter/blocs/states/dashboard_recruiter_state.dart';

// class DashboardRecruiterPage extends StatelessWidget {
//   const DashboardRecruiterPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => DashboardRecruiterBloc(
//         usecase: DashboardRecruiterUsecaseImp(
//           repository: DashboardRecruiterRepositoryImplementation(
//             datasource: GetDashboardDataSourceImp(),
//           ),
//         ),
//       ),
//       child: Scaffold(
//         body: BlocBuilder<DashboardRecruiterBloc, DashboardRecruiterState>(
//           builder: (context, state) {
//             if (state is LoadingDashboardRecruiterState) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (state is ListJobsDashboardRecruiterState) {
//               return ListView.builder(
//                 itemCount: state.listJobs.length,
//                 itemBuilder: (context, index) {
//                   final job = state.listJobs[index];
//                   return ListTile(
//                     title: Text(job.title),
//                     subtitle: Text(job.company),
//                   );
//                 },
//               );
//             } else if (state is EmptyDashboardRecruiterState) {
//               return const Center(
//                 child: Text('No jobs found'),
//               );
//             } else if (state is ErrorDashboardRecruiterState) {
//               return const Center(
//                 child: Text("Error"),
//               );
//             } else {
//               return const Center(
//                 child: Text('Unknown state'),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
