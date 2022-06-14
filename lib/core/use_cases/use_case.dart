import 'package:dartz/dartz.dart';

import '../error/failure.dart';

///!Base class for use cases in order to let the use case decide which type returns
abstract class UseCase<Type, Params>{
  Future<Either<Failure, Type>> call({required Params params});
}