import 'package:fpdart/fpdart.dart';
import '../features/movie/domain/entity/movie.dart';
import 'error/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, List<Movie>>> call(Params params);
}
