part of 'app_key_cubit.dart';

abstract class AppKeyState extends Equatable {
  const AppKeyState();

  @override
  List<Object> get props => [];
}

class AppKeyInitial extends AppKeyState {}

class AppKeyAbsent extends AppKeyState {}

class AppKeyPresent extends AppKeyState {}
