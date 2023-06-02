import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/domain/repositories/reset_password_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/domain/usecases/reset_password_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/infra/datasources/reset_password_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/infra/datasources/reset_password_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/infra/repositories/reset_password_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/reset_password/presenter/blocs/blocs/reset_password_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class ResetPasswordServiceLocatorConfig
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
    sl.registerLazySingleton<ResetPasswordDatasource>(() =>
        ResetPasswordDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<ResetPasswordRepository>(() =>
        ResetPasswordRepositoryImplementation(
            datasource: sl<ResetPasswordDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(
        () => ResetPasswordUsecase(repository: sl<ResetPasswordRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => ResetPasswordBloc(
          resetPasswordUsecase: sl<ResetPasswordUsecase>(),
        ));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
