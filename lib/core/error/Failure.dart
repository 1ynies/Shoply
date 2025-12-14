/// Base class for all application failures.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Represents errors specific to the database (e.g., network timeout, not found).
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Represents local errors (e.g., caching issues, permissions).
class LocalFailure extends Failure {
  const LocalFailure(super.message);
}