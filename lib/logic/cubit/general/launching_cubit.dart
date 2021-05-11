import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/phone_lock_cubit.dart';

part 'launching_state.dart';

class LaunchingCubit extends Cubit<LaunchingState> {
  final PhoneLockCubit phoneLockCubit;
  late StreamSubscription phoneLockSS;

  LaunchingCubit({required this.phoneLockCubit})
      : super(LaunchingSplashScreen()) {
    monitorPhoneLock();
  }

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

  void launchLoginScreen() {
    log('LaunchingCubit - launchLoginScreen');
    emit(LaunchingLoginScreen());
  }

  void launchSetPinCodeScreen() {
    log('LaunchingCubit - launchSetPinCodeScreen');
    emit(LaunchingSetPinCodeScreen());
  }

  void launchAuthScreen() {
    log('LaunchingCubit - launchAuthScreen');
    emit(LaunchingAuthScreen());
  }

  void launchHomeScreen() {
    log('LaunchingCubit - launchHomeScreen');
    emit(LaunchingHomeScreen());
  }

  void monitorPhoneLock() {
    log('LaunchingCubit - monitorPhoneLock');
    phoneLockSS = phoneLockCubit.stream.listen((phoneLockState) {
      if (phoneLockState is PhoneHasLock)
        emit(LaunchingAuthScreen());
      else
        emit(LaunchingSettingSecurityScreen());
    });
  }

  @override
  Future<void> close() {
    phoneLockSS.cancel();
    return super.close();
  }
}
