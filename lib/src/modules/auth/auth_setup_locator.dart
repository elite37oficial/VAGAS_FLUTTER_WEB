import 'package:vagas_flutter_web/src/modules/auth/features/login/login_service_locator_config.dart';
import 'package:vagas_flutter_web/src/modules/auth/features/register/register_service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class AuthSetupLocator implements ServiceLocatorModuleConfig {
  final List<ServiceLocatorConfig> _features = [
    LoginServiceLocatorConfig(),
    RegisterServiceLocatorConfig(),
  ];

  @override
  void setup(ServiceLocatorWrapper sl) {
    for (var serviceLocatorConfig in _features) {
      serviceLocatorConfig.configure(sl);
    }
  }
}
