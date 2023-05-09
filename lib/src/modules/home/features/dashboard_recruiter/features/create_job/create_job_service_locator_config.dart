import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/repositories/create_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/repositories/get_companies_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/usecases/create_job_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/domain/usecases/get_companies_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/create_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/create_job_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/get_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/datasources/get_companies_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/repositories/create_job_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/infra/repositories/get_companies_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/create_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/presenter/blocs/blocs/get_companies_bloc.dart';
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
    sl.registerLazySingleton<GetCompaniesDatasource>(() =>
        GetCompaniesDatasourceImplementation(
            requester: AppRequesterImplementation()));
    sl.registerLazySingleton<CreateJobDatasource>(() =>
        CreateJobDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<GetCompaniesRepository>(() =>
        GetCompaniesRepositoryImplementation(
            datasource: sl<GetCompaniesDatasource>()));
    sl.registerLazySingleton<CreateJobRepository>(() =>
        CreateJobRepositoryImplementation(
            datasource: sl<CreateJobDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => GetCompaniesUsecase(repository: sl<GetCompaniesRepository>()));
    sl.registerFactory(
        () => CreateJobUsecase(repository: sl<CreateJobRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => GetCompaniesBloc(usecase: sl<GetCompaniesUsecase>()));
    sl.registerFactory(() => CreateJobBloc(usecase: sl<CreateJobUsecase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
