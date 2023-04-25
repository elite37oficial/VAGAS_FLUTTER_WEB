import 'package:get_it/get_it.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/app_locator.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/get_it_wrapper.dart';
import 'package:vagas_flutter_web/src/shared/service_locator/service_locator_wrapper.dart';

final GetIt sl = GetIt.instance;
final GetIt root = GetIt.asNewInstance();
final ServiceLocatorWrapper slWrapper = GetItWrapper(sl);

void setupLocator() {
  AppLocator.setupLocator(slWrapper);
}



