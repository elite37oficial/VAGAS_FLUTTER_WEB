abstract class AppHttpRequester {
  Future<T> post<T>({
    String url,
    Map<String, String>? header,
    dynamic body,
    required T Function(Map<String, dynamic>) fromJson,
  });

  Future<T> put<T>({
    String url,
    Map<String, String>? header,
    dynamic body,
    required T Function(Map<String, dynamic>) fromJson,
  });

  Future<T> get<T>({
    String url,
    Map<String, String>? header,
    T Function(Map<String, dynamic>)? fromJson,
  });

  Future<T> delete<T>({
    String url,
    Map<String, String>? header,
    dynamic body,
    T Function(Map<String, dynamic>)? fromJson,
  });
}
