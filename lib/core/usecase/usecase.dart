/// Base interface for all UseCases.
/// [Type] is the return type of the use case.
/// [Params] is the parameter type passed to the use case.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// Helper class when a UseCase needs no parameters.
class NoParams {}