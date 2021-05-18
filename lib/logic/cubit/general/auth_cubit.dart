import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/AppConstants.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.prefs}) : super((AuthInitialState())) {
    log('AuthCubit');
    if (prefs.containsKey(SPKeys.biometricOn)) {
      log('AuthCubit - biometricOn: ${prefs.getBool(SPKeys.biometricOn)}');
      if (prefs.getBool(SPKeys.biometricOn)!)
        emit(BiometricOn());
      else
        emit(BiometricOff());
    }
  }

  final SharedPreferences prefs;
  final LocalAuthentication _auth = LocalAuthentication();

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(
        'AuthCubit - onChange - ${change.currentState.toString()} --> ${change.nextState.toString()}');
  }

  Future<bool> isBiometricSupported() async => await _auth.isDeviceSupported();
  Future<bool> canCheckBiometrics() async => await _auth.canCheckBiometrics;

  void setBiometricLoginOff() {
    log('AuthCubit - setBiometricLoginOff');
    prefs.setBool(SPKeys.biometricOn, false);
    emit(BiometricOff());
  }

  void setBiometricLoginOn() {
    log('AuthCubit - setBiometricLoginOn');
    prefs.setBool(SPKeys.biometricOn, true);
    emit(BiometricOn());
  }

  Future<bool> authenticateWithBiometricsIfOn(
      {required BuildContext context}) async {
    log('AuthCubit - authenticateWithBiometricsIfOn');
    // var isDeviceSupported = await _auth.isDeviceSupported();
    var canCheckBiometrics = await _auth.canCheckBiometrics;

    // var availableMiometrics = await _auth.getAvailableBiometrics();
    // log('isDeviceSupported $isDeviceSupported');
    // log('canCheckBiometrics $canCheckBiometrics');
    // log('availableMiometrics $availableMiometrics');

    if ((await isBiometricSupported()) == false) {
      emit(BiometricOff());
      return false;
    }

    bool isAuthenticated = false;

    if (canCheckBiometrics) {
      try {
        isAuthenticated = await _auth.authenticate(
          localizedReason: AppLocalizations.of(context)!.confirmIdentity,
          biometricOnly: true,
          stickyAuth: true,
          // sensitiveTransaction: true,
          useErrorDialogs:
              true, // TODO not working, there is a bug in package https://github.com/flutter/flutter/issues/80259
          androidAuthStrings: AndroidAuthMessages(
            // biometricHint: 'biometricHint',
            // biometricNotRecognized: 'biometricNotRecognized',
            // biometricRequiredTitle: 'biometricRequiredTitle',
            // biometricSuccess: 'biometricSuccess',
            // cancelButton: 'cancelButton',
            // deviceCredentialsRequiredTitle: 'deviceCredentialsRequiredTitle',
            // deviceCredentialsSetupDescription:
            //     'deviceCredentialsSetupDescription',
            // goToSettingsButton: 'goToSettingsButton',
            // goToSettingsDescription: 'goToSettingsDescription',
            signInTitle: AppLocalizations.of(context)!.authenticationRequired,
          ),
        );
      } on Exception catch (e) {
        // TODO try catch PlatformException
        log(e.toString());
      }
    }
    return isAuthenticated;
  }
}
