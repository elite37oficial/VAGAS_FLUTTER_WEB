import 'service_locator_wrapper.dart';

abstract class ServiceLocatorConfig {
  Future<void> configure(ServiceLocatorWrapper sl);
}

abstract class ServiceLocatorConfigInternals {
  void registerManagerState(ServiceLocatorWrapper sl);
  void registerUseCases(ServiceLocatorWrapper sl);
  void registerRepositories(ServiceLocatorWrapper sl);
  void registerDataSources(ServiceLocatorWrapper sl);
  void registerServices(ServiceLocatorWrapper sl);
}

abstract class ServiceLocatorModuleConfig {
  void setup(ServiceLocatorWrapper sl);
}
