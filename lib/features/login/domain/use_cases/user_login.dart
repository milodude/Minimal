import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:coda_test/core/use_cases/use_case.dart';
import 'package:coda_test/features/login/domain/entities/user_info.dart';
import 'package:coda_test/features/login/domain/repository/user_repository.dart';

import '../../../../core/error/failure.dart';

class UserLogin implements UseCase<UserInfo, Params>{
  final UserRepository userRepository;
  UserLogin({
    required this.userRepository,
  });
  
  @override
  Future<Either<Failure, UserInfo>> call(Params params) async {
        return await userRepository.login(userName: params.userName, password: params.password);
  }
}
///!Params class for this use case
class Params extends Equatable {
  final String userName;
  final String password;

  const Params({
    required this.userName,
    required this.password,
  });
  @override
  List<Object?> get props => [userName, password];

}
