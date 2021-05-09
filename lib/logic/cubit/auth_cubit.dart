import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/core/constants/AppConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.prefs}) : super(NotAuthenticated()) {
    if (prefs.containsKey(SPKeys.securityOn)) {
      if (prefs.getBool(SPKeys.securityOn)! == false) emit(NoSecurityMode());
    }
  }

  final SharedPreferences prefs;
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> isBiometricSupported() async => await _auth.isDeviceSupported();

  void setNoSecurityMode() {
    log('AuthCubit - setNoSecurityMode');
    prefs.setBool(SPKeys.securityOn, false);
    emit(NoSecurityMode());
  }

  void authenticateWithBiometrics({required BuildContext context}) async {
    log('AuthCubit - authenticateWithBiometrics');
    emit(AuthInProgress());

    if ((await isBiometricSupported()) == false) {
      emit(SecurityRequired());
      return;
    }
    bool canCheckBiometrics = await _auth.canCheckBiometrics;
    bool isAuthenticated = false;

    if (canCheckBiometrics) {
      try {
        isAuthenticated = await _auth.authenticate(
          localizedReason: AppLocalizations.of(context)!.confirmIdentity,
          // biometricOnly: true,
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

        log('isAuthenticated: $isAuthenticated');
        if (isAuthenticated)
          emit(Authenticated());
        else
          emit(NotAuthenticated());
      }
    } else
      emit(NotAuthenticated());
  }
}
