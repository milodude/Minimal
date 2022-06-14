import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{}

//! General Failure
class ServerFailure extends Failure {
  final String message;
  ServerFailure(
    this.message,
  );

  @override
  List<Object?> get props => [message];
}