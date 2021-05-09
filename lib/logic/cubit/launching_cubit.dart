import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'launching_state.dart';

class LaunchingCubit extends Cubit<LaunchingState> {
  LaunchingCubit() : super(LaunchingSplashScreen());

  @override
  void onChange(Change<LaunchingState> change) {
    super.onChange(change);
    print(
        'LaunchingCubit - onChange - ${change.currentState.toString()} --> ${change.nextState.toString()}');
  }

  Future<void> launchStartScreen() async {
    log('LaunchingCubit - launchStartScreen');
    await Future.delayed(Duration(seconds: 2));
    emit(LaunchingStartScreen());
  }

  void launchAuthScreen() {
    log('LaunchingCubit - launchAuthScreen');
    emit(LaunchingAuthScreen());
  }

  void launchHomeScreen() {
    log('LaunchingCubit - launchHomeScreen');
    emit(LaunchingHomeScreen());
  }
}
