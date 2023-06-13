import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/repositories/admin_get_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/domain/usecases/admin_get_job_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/infra/datasources/admin_get_job_datasouce_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/infra/datasources/admin_get_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/infra/repositories/admin_get_job_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

import 'presenter/blocs/blocs/admin_get_job_bloc.dart';

class AdminJobsServiceLocatorConfig
    implements ServiceLocatorConfigInternals, ServiceLocatorConfig {
  @override
  Future<void> configure(ServiceLocatorWrapper sl) async {
    registerManagerState(sl);
    registerUseCases(sl);
    registerRepositories(sl);
    registerDataSources(sl);
    registerServices(sl);
  }

  @override
  void registerDataSources(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<AdminGetJobDatasource>(() =>
        AdminGetJobDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<AdminGetJobRepository>(() =>
        AdminGetJobRepositoryImplementation(
            datasource: sl<AdminGetJobDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => AdminGetJobUsecase(repository: sl<AdminGetJobRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => AdminGetJobBloc(usecase: sl<AdminGetJobUsecase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
