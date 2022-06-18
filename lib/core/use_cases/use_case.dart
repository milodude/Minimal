import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

///!Base class for use cases in order to let the use case decide which type returns
abstract class UseCase<Type, Params>{
  Future<Either<Failure, Type>> call(Params params);
}

///!Many use cases will be needing noParams so must be here.
class NoParams extends Equatable{
  @override
  List<Object?> get props => [];
}