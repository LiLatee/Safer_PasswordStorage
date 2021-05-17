import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_simple_password_storage_clean/core/constants/AppConstants.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/login_cubit.dart';

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
