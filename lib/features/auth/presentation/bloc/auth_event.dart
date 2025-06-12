part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckLoginEvent extends AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  final String username;
  final String password;
  final String mpin;

  const AuthRegisterEvent({
    required this.username,
    required this.password,
    required this.mpin,
  });

  @override
  List<Object> get props => [username, password, mpin];
}

class AuthLoginEvent extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class AuthLoginWithMpinEvent extends AuthEvent {
  final String mpin;

  const AuthLoginWithMpinEvent({required this.mpin});

  @override
  List<Object> get props => [mpin];
}


class AuthLogoutEvent extends AuthEvent {}
