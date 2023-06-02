import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/repositories/edit_get_all_companies_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/repositories/edit_job_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/repositories/get_job_by_id_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/usecases/edit_get_all_companies_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/usecases/edit_job_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/domain/usecases/get_job_by_id_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/edit_get_all_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/edit_get_all_companies_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/edit_job_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/edit_job_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/get_job_by_id_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/datasources/get_job_by_id_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/repositories/edit_get_all_companies_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/repositories/edit_job_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/infra/repositories/get_job_by_id_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/blocs/blocs/edit_get_all_companies_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/blocs/blocs/edit_job_bloc.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/edit_job/presenter/blocs/blocs/get_job_by_id_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class EditJobServiceLocatorConfig
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
    sl.registerLazySingleton<EditJobDatasource>(() =>
        EditJobDatasourceImplementation(
            requester: AppRequesterImplementation()));
    sl.registerLazySingleton<GetJobByIdDatasource>(() =>
        GetJobByIdDatasourceImplementation(
            requester: AppRequesterImplementation()));
    sl.registerLazySingleton<EditGetAllCompaniesDatasource>(() =>
        EditGetAllCompaniesDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<EditJobRepository>(() =>
        EditJobRepositoryImplementation(datasource: sl<EditJobDatasource>()));
    sl.registerLazySingleton<GetJobByIdRepository>(() =>
        GetJobByIdRepositoryImplementation(datasource: sl<GetJobByIdDatasource>()));
    sl.registerLazySingleton<EditGetAllCompaniesRepository>(() =>
        EditGetAllCompaniesRepositoryImplementation(
            datasource: sl<EditGetAllCompaniesDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => EditJobUsecase(repository: sl<EditJobRepository>()));
    sl.registerFactory(
        () => GetJobByIdUsecase(repository: sl<GetJobByIdRepository>()));
    sl.registerFactory(() => EditGetAllCompaniesUsecase(
        repository: sl<EditGetAllCompaniesRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => EditJobBloc(usecase: sl<EditJobUsecase>()));
    sl.registerFactory(() => GetJobByIdBloc(usecase: sl<GetJobByIdUsecase>()));
    sl.registerFactory(() =>
        EditGetAllCompaniesBloc(usecase: sl<EditGetAllCompaniesUsecase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
