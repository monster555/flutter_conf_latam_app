sealed class Result<T, E> {
  const Result();
}

class Success<T, E> extends Result<T, E> {
  const Success(this.value);
  final T value;
}

class Failure<T, E> extends Result<T, E> {
  const Failure(this.error);
  final E error;
}

typedef FutureResult<T, E> = Future<Result<T, E>>;
