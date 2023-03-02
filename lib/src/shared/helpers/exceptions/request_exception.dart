class RequestException implements Exception {
  int? statusCode;
  String? message;

  RequestException({
    this.statusCode,
    this.message,
  });
}
