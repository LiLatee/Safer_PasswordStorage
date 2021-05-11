import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

part 'phone_lock_state.dart';

class PhoneLockCubit extends Cubit<PhoneLockState> with WidgetsBindingObserver {
  final LocalAuthentication localAuth;

  PhoneLockCubit({required this.localAuth}) : super(PhoneLockInitial()) {
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void onChange(Change<PhoneLockState> change) {
    super.onChange(change);
    print(
        'LaunchingCubit - onChange - ${change.currentState.toString()} --> ${change.nextState.toString()}');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    checkIfPhoneHasLock();
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance!.removeObserver(this);
    return super.close();
  }

  Future<void> checkIfPhoneHasLock() async {
    log('PhoneLockCubit - checkIfPhoneHasLock');

    if (await localAuth.isDeviceSupported())
      emit(PhoneHasLock());
    else
      emit(PhoneHasNotLock());
  }
}
