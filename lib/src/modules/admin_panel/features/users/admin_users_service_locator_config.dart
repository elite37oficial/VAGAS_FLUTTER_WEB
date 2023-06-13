import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/repositories/admin_get_users_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/usecases/admin_get_users_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/datasources/admin_get_users_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/datasources/admin_get_users_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/repositories/admin_get_users_repository_implementation.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

import 'presenter/blocs/blocs/get_users_bloc.dart';

class AdminUsersServiceLocatorConfig
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
    sl.registerLazySingleton<AdminGetUsersDatasource>(() =>
        AdminGetUsersDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<AdminGetUsersRepository>(() =>
        AdminGetUsersRepositoryImplementation(
            datasource: sl<AdminGetUsersDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => AdminGetUsersUsecase(repository: sl<AdminGetUsersRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => AdminGetUsersBloc(usecase: sl<AdminGetUsersUsecase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
