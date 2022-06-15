import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:coda_test/features/login/domain/entities/user_info.dart';
import 'package:coda_test/features/login/domain/use_cases/user_login.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserLogin userLoginUseCase;
  UserBloc(
    {required this.userLoginUseCase}
  ) : super(const UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(const Loading());
        final result = await userLoginUseCase(params: Params(userName: event.userName, password: event.password));
        result.fold(
          (left) => emit(Error(errorMessage: left.toString())),
          (right){
            emit(Loaded(right));},
        );
      }
    });
  }
}
