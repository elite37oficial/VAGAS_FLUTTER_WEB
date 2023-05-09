import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/company/companies_service_locator_config.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_company/create_company_service_locator_config.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/create_job/create_job_service_locator_config.dart';
import 'package:vagas_flutter_web/src/modules/home/features/dashboard_recruiter/features/jobs/jobs_service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_config.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

class HomeSetupLocator implements ServiceLocatorModuleConfig {
  final List<ServiceLocatorConfig> _features = [
    JobsServiceLocatorConfig(),
    CreateJobServiceLocatorConfig(),
    CompaniesServiceLocatorConfig(),
    CreateCompanyServiceLocatorConfig(),
  ];

  @override
  void setup(ServiceLocatorWrapper sl) {
    for (var serviceLocatorConfig in _features) {
      serviceLocatorConfig.configure(sl);
    }
  }
}
