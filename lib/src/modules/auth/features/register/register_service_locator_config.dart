import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/repositories/register_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/domain/usecases/register_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/datasources/register_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/datasources/register_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/infra/repositories/register_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/presenter/blocs/blocs/register_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class RegisterServiceLocatorConfig
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
    sl.registerLazySingleton<RegisterDatasource>(() =>
        RegisterDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<RegisterRepository>(() =>
        RegisterRepositoryImplementation(datasource: sl<RegisterDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => RegisterUseCase(repository: sl<RegisterRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => RegisterBloc(usecase: sl<RegisterUseCase>()));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
