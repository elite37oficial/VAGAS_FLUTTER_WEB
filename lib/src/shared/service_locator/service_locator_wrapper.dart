abstract class ServiceLocatorWrapper {
  void registerFactory<T extends Object>(T Function() factoryfunc,
      {String? instanceName});

  void registerSingleton<T extends Object>(T instance, {String? instanceName});

  void registerLazySingleton<T extends Object>(T Function() factoryfunc,
      {String? instanceName});

  T get<T extends Object>({String? instanceName});

  T call<T extends Object>({String? instanceName});

  bool isRegistered<T extends Object>({Object? instance, String? instanceName});
}
