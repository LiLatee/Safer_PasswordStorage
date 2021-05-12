import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/login_cubit.dart';

part 'launching_state.dart';

class LaunchingCubit extends Cubit<LaunchingState> with WidgetsBindingObserver {
  final LoginCubit loginCubit;
  LaunchingCubit({required this.loginCubit}) : super(LaunchingSplashScreen()) {
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (loginCubit.checkIfPinCodeExists())
        emit(LaunchingLoginScreen());
      else
        emit(LaunchingSetPinCodeScreen());
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance!.removeObserver(this);
    return super.close();
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
}
