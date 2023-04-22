import 'package:get_it/get_it.dart';

import 'service_locator_wrapper.dart';

class GetItWrapper implements ServiceLocatorWrapper {
  const GetItWrapper(this._getIt);

  final GetIt _getIt;

  @override
  T call<T extends Object>({String? instanceName}) =>
      _getIt.call<T>(instanceName: instanceName);

  @override
  T get<T extends Object>({String? instanceName}) =>
      _getIt.get<T>(instanceName: instanceName);

  @override
  void registerFactory<T extends Object>(T Function() factoryfunc,
      {String? instanceName}) {
    _getIt.registerFactory<T>(factoryfunc, instanceName: instanceName);
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() factoryfunc,
      {String? instanceName}) {
    _getIt.registerLazySingleton<T>(factoryfunc, instanceName: instanceName);
  }

  @override
  void registerSingleton<T extends Object>(T instance, {String? instanceName}) {
    _getIt.registerSingleton<T>(instance, instanceName: instanceName);
  }

  @override
  bool isRegistered<T extends Object>(
      {Object? instance, String? instanceName}) {
    return _getIt.isRegistered<T>(
      instance: instance,
      instanceName: instanceName,
    );
  }
}
