part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  final UserInfo userinfo;
  const UserState({
    required this.userinfo,
  });

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  const UserInitial():super(userinfo: emptyUser);
}

class Loading extends UserState {
  const Loading() : super(userinfo: emptyUser);
}

class Loaded extends UserState {
  final UserInfo user;

  const Loaded(this.user) : super(userinfo: user);
}

class Error extends UserState {
  final String errorMessage;

  const Error({required this.errorMessage}) : super(userinfo: emptyUser);
}

const UserInfo emptyUser = UserInfo(id: 0, firstName: '', lastName: '', email: '', photo: '', accessToken: '');