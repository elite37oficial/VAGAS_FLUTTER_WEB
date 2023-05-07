
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/repositories/get_users_repository.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/domain/usecases/get_users_usecase.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/datasources/get_users_datasource.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/datasources/get_users_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/infra/repositories/get_users_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/presenter/blocs/blocs/get_users_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class UsersServiceLocatorConfig
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
    sl.registerLazySingleton<GetUsersDatasource>(() =>
        GetUsersDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<GetUsersRepository>(() =>
        GetUsersRepositoryImplementation(datasource: sl<GetUsersDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => GetUsersUsecase(repository: sl<GetUsersRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => GetUsersBloc(usecase: sl<GetUsersUsecase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
