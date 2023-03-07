class RequestException implements Exception {
  int? statusCode;
  String? message;

  RequestException({
    this.statusCode,
    this.message,
  });
}

class InvalidCredentialsException implements Exception {
  int? statusCode;
  String? message;

  InvalidCredentialsException({
    this.statusCode,
    this.message,
  });
}

class ServerException implements Exception {
  int? statusCode;
  String? message;

  ServerException({
    this.statusCode,
    this.message,
  });
}

class BadRequestException implements Exception {
  int? statusCode;
  String? message;

  BadRequestException({
    this.statusCode,
    this.message,
  });
}
