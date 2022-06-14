import 'package:dartz/dartz.dart';

import 'package:coda_test/core/error/failure.dart';
import 'package:coda_test/features/login/data/data_source/user_data_source.dart';
import 'package:coda_test/features/login/domain/entities/user_info.dart';

import '../../domain/repository/user_repository.dart' as domain;

class UserRepositoryImpl extends domain.UserRepository {
  UserDataSource userDataSource;
  UserRepositoryImpl({
    required this.userDataSource,
  });
  @override
  Future<Either<Failure, UserInfo>> login({required String userName, required String password}) async{
     try {
      var result = await userDataSource.login(userName:userName, password:password);
      return Right(result);
    } on ServerFailure catch(e){
     return Left(ServerFailure('Server error while sending the request'));
    }catch(e){
     return Left(ServerFailure('Server error while sending the request'));
    }
  }
}
