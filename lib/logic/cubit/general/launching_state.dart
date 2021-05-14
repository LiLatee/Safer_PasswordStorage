part of 'launching_cubit.dart';

abstract class LaunchingState extends Equatable {
  const LaunchingState();

  @override
  List<Object> get props => [];
}

class LaunchingSplashScreen extends LaunchingState {}

class LaunchingLoginScreen extends LaunchingState {}

class LaunchingSetPinCodeScreen extends LaunchingState {}

// class LaunchingStartScreen extends LaunchingState {}
