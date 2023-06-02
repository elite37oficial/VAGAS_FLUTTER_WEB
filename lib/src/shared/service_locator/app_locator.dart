import 'package:vagas_flutter_web/src/modules/admin_panel/admin_panel_setup_locator.dart';
import 'package:vagas_flutter_web/src/modules/auth/auth_setup_locator.dart';
import 'package:vagas_flutter_web/src/modules/home/home_setup_locator.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

late ServiceLocatorWrapper globalSL;

class AppLocator {
  static void setupLocator(ServiceLocatorWrapper serviceLocator) {
    globalSL = serviceLocator;
    AuthSetupLocator().setup(globalSL);
    HomeSetupLocator().setup(globalSL);
    AdminPanelSetupLocator().setup(globalSL);
  }
}
