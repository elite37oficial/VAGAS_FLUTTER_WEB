import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/domain/repositories/forgot_password_repository.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/domain/usecases/forgot_password_usecase.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/infra/datasources/forgot_password_datasource.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/infra/datasources/forgot_password_datasource_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/infra/repositories/forgot_password_repository_implementation.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/forgot_password/presenter/blocs/blocs/forgot_password_bloc.dart';
import 'package:vagas_flutter_web/src/shared/requester/app_requester_implementation.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class ForgotPasswordServiceLocatorConfig
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
    sl.registerLazySingleton<ForgotPasswordDatasource>(() =>
        ForgotPasswordDatasourceImplementation(
            requester: AppRequesterImplementation()));
  }

  @override
  void registerRepositories(ServiceLocatorWrapper sl) {
    sl.registerLazySingleton<ForgotPasswordRepository>(() =>
        ForgotPasswordRepositoryImplementation(
            datasource: sl<ForgotPasswordDatasource>()));
  }

  @override
  void registerUseCases(ServiceLocatorWrapper sl) {
    sl.registerFactory(() =>
        ForgotPasswordUsecase(repository: sl<ForgotPasswordRepository>()));
  }

  @override
  void registerManagerState(ServiceLocatorWrapper sl) {
    sl.registerFactory(() => ForgotPasswordBloc(
          forgotPasswordUsecase: sl<ForgotPasswordUsecase>(),
        ));
  }

  @override
  void registerServices(ServiceLocatorWrapper sl) {}
}
