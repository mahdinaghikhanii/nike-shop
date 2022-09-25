part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthButtonIsClicked extends AuthEvent {
  final String userName;
  final String password;
  const AuthButtonIsClicked(this.password, this.userName);
}

class AuthModeChanfeIsClicked extends AuthEvent {}
