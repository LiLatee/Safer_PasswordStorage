import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/AppConstants.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SharedPreferences prefs;
  LoginCubit({required this.prefs}) : super(LoginInitial());

  bool checkIfPinCodeExists() {
    log('LoginCubit - checkIfPinCodeExists');
    return prefs.containsKey(SPKeys.pincode);
  }

  bool checkPinCode({required String pincode}) {
    log('LoginCubit - checkPinCode');
    if (prefs.containsKey(SPKeys.pincode)) {
      if (pincode == prefs.getString(SPKeys.pincode)) return true;
    }
    return false;
  }

  void savePinCode({required String pincode}) {
    log('LoginCubit - savePinCode');
    prefs.setString(SPKeys.pincode, pincode);
  }
}
