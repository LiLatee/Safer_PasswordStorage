import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/auth_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/launching_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/login_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();
  String? currentText;

  bool isAuthenticated = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (BlocProvider.of<AuthCubit>(context).state is BiometricOn) {
      isAuthenticated = await BlocProvider.of<AuthCubit>(context)
          .authenticateWithBiometricsIfOn(context: context);
    }

    if (isAuthenticated)
      BlocProvider.of<LaunchingCubit>(context).launchHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: PinCodeTextField(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            length: 4,
            obscureText: true,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              // borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.grey.shade200,
              inactiveColor: Colors.red,
              activeColor: Colors.green,
              disabledColor: Colors.white,
              selectedColor: Colors.blue,
              selectedFillColor: Colors.white,
              inactiveFillColor: Colors.white,
            ),
            animationDuration: Duration(milliseconds: 300),
            // backgroundColor: Colors.blue.shade50,
            enableActiveFill: true,
            errorAnimationController: errorController,
            controller: textEditingController,
            onCompleted: (v) {
              print("Completed");
              if (BlocProvider.of<LoginCubit>(context)
                  .checkPinCode(pincode: currentText!))
                BlocProvider.of<LaunchingCubit>(context).launchHomeScreen();
            },
            onChanged: (value) {
              print(value);
              setState(() {
                currentText = value;
              });
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return false;
            },
            appContext: context,
            validator: (value) {
              if (!BlocProvider.of<LoginCubit>(context).checkPinCode(
                  pincode: currentText!)) return "Nieprawidłowy pin";
            },
          ),
        ),
      ),
    );
  }
}
