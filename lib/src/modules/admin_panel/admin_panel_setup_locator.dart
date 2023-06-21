import 'package:vagas_flutter_web/src/modules/admin_panel/features/company/companies_service_locator_config.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_company/admin_create_company_service_locator_config.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/create_job/admin_create_job_service_locator_config.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/jobs/admin_jobs_service_locator_config.dart';
import 'package:vagas_flutter_web/src/modules/admin_panel/features/users/admin_users_service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class AdminPanelSetupLocator implements ServiceLocatorModuleConfig {
  final List<ServiceLocatorConfig> _features = [
    AdminUsersServiceLocatorConfig(),
    AdminJobsServiceLocatorConfig(),
    AdminCreateJobServiceLocatorConfig(),
    AdminCompaniesServiceLocatorConfig(),
    AdminCreateCompanyServiceLocatorConfig(),
  ];

  @override
  void setup(ServiceLocatorWrapper sl) {
    for (var serviceLocatorConfig in _features) {
      serviceLocatorConfig.configure(sl);
    }
  }
}
