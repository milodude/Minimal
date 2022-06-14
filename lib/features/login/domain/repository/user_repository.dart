import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_info.dart';

abstract class  UserRepository{
  Future<Either<Failure, UserInfo>> login({required String userName, required String password});
}