import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/repositories/get_all_companies_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/usecases/get_all_companies_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/create_job_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/get_all_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/get_all_companies_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/repositories/create_job_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/create_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/repositories/create_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/usecases/create_job_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/create_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/repositories/get_all_companies_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/get_all_companies_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';


class CreateJobServiceLocatorConfig
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
    sl.registerLazySingleton<CreateJobDatasource>(() =>
        CreateJobDatasourceImplementation(
            requester: AppRequesterImplementation()));
    sl.registerLazySingleton<GetAllCompaniesDatasource>(() =>
        GetAllCompaniesDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<CreateJobRepository>(() =>
        CreateJobRepositoryImplementation(
            datasource: sl<CreateJobDatasource>()));
    sl.registerLazySingleton<GetAllCompaniesRepository>(() =>
        GetAllCompaniesRepositoryImplementation(
            datasource: sl<GetAllCompaniesDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => CreateJobUsecase(repository: sl<CreateJobRepository>()));
    sl.registerFactory(
        () => GetAllCompaniesUsecase(repository: sl<GetAllCompaniesRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => CreateJobBloc(usecase: sl<CreateJobUsecase>()));
    sl.registerFactory(() =>GetAllCompaniesBloc(usecase: sl<GetAllCompaniesUsecase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
