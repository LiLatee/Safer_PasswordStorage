part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {}

class BiometricOn extends AuthState {}

class BiometricOff extends AuthState {}

// class NotAuthenticated extends AuthState {}

// class Authenticated extends AuthState {}

// class AuthInProgress extends AuthState {}

// class AuthFailure extends AuthState {}

// class SecurityModeOn extends AuthState {}

// class SecurityModeOff extends AuthState {}
