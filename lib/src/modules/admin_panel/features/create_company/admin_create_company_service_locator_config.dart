import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/repositories/admin_create_company_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/domain/usecases/admin_create_company_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/datasources/admin_create_company_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/datasources/admin_create_company_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/infra/repositories/admin_create_company_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/presenter/blocs/blocs/admin_create_company_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class AdminCreateCompanyServiceLocatorConfig
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
    sl.registerLazySingleton<AdminCreateCompanyDatasource>(() =>
        AdminCreateCompanyDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<AdminCreateCompanyRepository>(() =>
        AdminCreateCompanyRepositoryImplementation(
            datasource: sl<AdminCreateCompanyDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => AdminCreateCompanyUsecase(
        repository: sl<AdminCreateCompanyRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(
      () => AdminCreateCompanyBloc(
        usecase: sl<AdminCreateCompanyUsecase>(),
      ),
    );
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
