import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/admin_jobs_service_locator_config.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/users_service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class AdminPanelSetupLocator implements ServiceLocatorModuleConfig {
  final List<ServiceLocatorConfig> _features = [
    UsersServiceLocatorConfig(),
    AdminJobsServiceLocatorConfig(),
  ];

  @override
  void setup(ServiceLocatorWrapper sl) {
    for (var serviceLocatorConfig in _features) {
      serviceLocatorConfig.configure(sl);
    }
  }
}
