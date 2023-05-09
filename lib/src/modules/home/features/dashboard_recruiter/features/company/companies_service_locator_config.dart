import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/repositories/get_companies_repository.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/domain/usecases/get_companies_usecase.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/infra/datasources/get_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/infra/datasources/get_companies_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/infra/repositories/get_companies_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/presenter/bloc/bloc/get_companies_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class CompaniesServiceLocatorConfig
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
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<GetCompaniesRepository>(() =>
        GetCompaniesRepositoryImplementation(
            datasource: sl<GetCompaniesDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => GetCompaniesUsecase(repository: sl<GetCompaniesRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => GetCompaniesBloc(usecase: sl<GetCompaniesUsecase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
