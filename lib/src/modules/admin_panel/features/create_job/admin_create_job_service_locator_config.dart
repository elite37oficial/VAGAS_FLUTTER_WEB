import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/repositories/admin_create_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/repositories/admin_get_all_companies_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/usecases/admin_create_job_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/domain/usecases/admin_get_all_companies_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/datasources/admin_create_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/datasources/admin_create_job_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/datasources/admin_get_all_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/datasources/admin_get_all_companies_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/repositories/admin_create_job_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/infra/repositories/admin_get_all_companies_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/presenter/blocs/blocs/admin_get_all_companies_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

import 'presenter/blocs/blocs/admin_create_job_bloc.dart';

class AdminCreateJobServiceLocatorConfig
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
    sl.registerLazySingleton<AdminCreateJobDatasource>(() =>
        AdminCreateJobDatasourceImplementation(
            requester: AppRequesterImplementation()));
    sl.registerLazySingleton<AdminGetAllCompaniesDatasource>(() =>
        AdminGetAllCompaniesDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<AdminCreateJobRepository>(() =>
        AdminCreateJobRepositoryImplementation(
            datasource: sl<AdminCreateJobDatasource>()));
    sl.registerLazySingleton<AdminGetAllCompaniesRepository>(() =>
        AdminGetAllCompaniesRepositoryImplementation(
            datasource: sl<AdminGetAllCompaniesDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(() =>
        AdminCreateJobUsecase(repository: sl<AdminCreateJobRepository>()));
    sl.registerFactory(() => AdminGetAllCompaniesUsecase(
        repository: sl<AdminGetAllCompaniesRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => AdminCreateJobBloc(usecase: sl<AdminCreateJobUsecase>()));
    sl.registerFactory(() =>
        AdminGetAllCompaniesBloc(usecase: sl<AdminGetAllCompaniesUsecase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
