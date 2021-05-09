part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class NotAuthenticated extends AuthState {}

class Authenticated extends AuthState {}

class AuthInProgress extends AuthState {}

class AuthFailure extends AuthState {}

class SecurityRequired extends AuthState {}

class NoSecurityMode extends AuthState {}
