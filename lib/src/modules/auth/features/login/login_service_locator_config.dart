import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/repositories/get_my_self_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/repositories/login_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/get_my_self_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/domain/usecases/login_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/get_my_self_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/get_my_self_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/login_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/datasources/login_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/repositories/get_my_self_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/infra/repositories/login_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/get_my_self_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/login/presenter/blocs/blocs/login_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class LoginServiceLocatorConfig
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
    sl.registerLazySingleton<LoginDatasource>(() =>
        LoginDatasourceImplementation(requester: AppRequesterImplementation()));
    sl.registerLazySingleton<GetMySelfDatasource>(() =>
        GetMySelfDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImplementation(datasource: sl<LoginDatasource>()));
    sl.registerLazySingleton<GetMySelfRepository>(() =>
        GetMySelfRepositoryImplementation(
            datasource: sl<GetMySelfDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => LoginUsecase(repository: sl<LoginRepository>()));
    sl.registerFactory(
        () => GetMySelfUsecase(repository: sl<GetMySelfRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => LoginBloc(
          loginUsecase: sl<LoginUsecase>(),
        ));
    sl.registerFactory(() => GetMySelfBloc(
          getMySelfUsecase: sl<GetMySelfUsecase>(),
        ));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
