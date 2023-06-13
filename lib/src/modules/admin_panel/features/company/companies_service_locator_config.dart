import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/repositories/admin_get_companies_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/domain/usecases/admin_get_companies_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/infra/datasources/admin_get_companies_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/infra/datasources/admin_get_companies_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/infra/repositories/admin_get_companies_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

import 'presenter/bloc/bloc/admin_get_companies_bloc.dart';

class AdminCompaniesServiceLocatorConfig
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
    sl.registerLazySingleton<AdminGetCompaniesDatasource>(() =>
        AdminGetCompaniesDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<AdminGetCompaniesRepository>(() =>
        AdminGetCompaniesRepositoryImplementation(
            datasource: sl<AdminGetCompaniesDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => AdminGetCompaniesUsecase(
        repository: sl<AdminGetCompaniesRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => AdminGetCompaniesBloc(usecase: sl<AdminGetCompaniesUsecase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
