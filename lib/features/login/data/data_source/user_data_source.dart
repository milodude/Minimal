import 'package:coda_test/features/login/data/model/user_model.dart';

abstract class UserRepository{
  Future<UserModel> login({required String userName,required String password}); 
}

class UserDataSource implements UserRepository{
  @override
  Future<UserModel> login({required String userName,required String password}) {
    throw UnimplementedError();
  }

}