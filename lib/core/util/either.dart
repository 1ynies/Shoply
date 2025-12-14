// A simple simulation of the popular functional programming pattern (Either<Failure, Success>)
// typedef Either<L, R> = ({L? left, R? right});


// lib/core/util/either.dart

abstract class Either<L, R> {
  // Add this 'fold' method 👇
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);
}

class Left<L, R> extends Either<L, R> {
  final L value;
  Left(this.value);

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) {
    return ifLeft(value);
  }
}

class Right<L, R> extends Either<L, R> {
  final R value;
  Right(this.value);

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) {
    return ifRight(value);
  }
}