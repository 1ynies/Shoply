/// Thrown when a server-side error occurs (e.g., Firebase errors).
class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => message;
}

/// Thrown when a cache error occurs.
class CacheException implements Exception {
  final String message;
  CacheException(this.message);
}

/// Thrown when auth specific errors occur (e.g., weak password).
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}