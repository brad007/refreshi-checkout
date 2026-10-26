import 'package:fpdart/fpdart.dart';

import '../error/failures.dart';

/// A single application action. Use cases are the only entry point from the
/// presentation layer into the domain.
abstract interface class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

/// A use case that produces a stream of results (e.g. live order updates).
abstract interface class StreamUseCase<T, Params> {
  Stream<Either<Failure, T>> call(Params params);
}

final class NoParams {
  const NoParams();
}
