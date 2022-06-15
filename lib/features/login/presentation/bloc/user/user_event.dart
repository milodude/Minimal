part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends UserEvent {
  final String userName;
  final String password;

  const LoginEvent({required this.userName, required this.password}):super();
}
