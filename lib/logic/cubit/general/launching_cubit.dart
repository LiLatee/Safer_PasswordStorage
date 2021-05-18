import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/constants/AppConstants.dart';
import 'login_cubit.dart';

part 'launching_state.dart';

class LaunchingCubit extends Cubit<LaunchingState> {
  final LoginCubit loginCubit;
  LaunchingCubit({required this.loginCubit}) : super(LaunchingSplashScreen());

  @override
  void onChange(Change<LaunchingState> change) {
    super.onChange(change);
    print(
        'LaunchingCubit - onChange - ${change.currentState.toString()} --> ${change.nextState.toString()}');
  }

  Future<void> launchLoginScreen() async {
    log('LaunchingCubit - launchLoginScreen');
    await Future.delayed(AppConstants.splashScreenDuration); // TODO

    emit(LaunchingLoginScreen());
  }

  Future<void> launchSetPinCodeScreen() async {
    log('LaunchingCubit - launchSetPinCodeScreen');
    await Future.delayed(AppConstants.splashScreenDuration); // TODO

    emit(LaunchingSetPinCodeScreen());
  }
}
