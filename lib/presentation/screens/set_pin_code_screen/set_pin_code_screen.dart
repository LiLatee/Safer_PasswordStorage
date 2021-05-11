import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/launching_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/login_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SetPinCodeScreen extends StatefulWidget {
  @override
  _SetPinCodeScreenState createState() => _SetPinCodeScreenState();
}

class _SetPinCodeScreenState extends State<SetPinCodeScreen> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  // TextEditingController textEditingController = TextEditingController();

  String? pinSet;
  String? pinRepeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildSetPinCode(context),
            SizedBox(
              height: 50,
            ),
            buildRepeatPinCode(context),
          ],
        ),
      ),
    );
  }

  Widget buildSetPinCode(BuildContext context) {
    return PinCodeTextField(
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
      // errorAnimationController: errorController,
      // controller: textEditingController,
      onCompleted: (v) {
        print("CompletedSet");
        // BlocProvider.of<LaunchingCubit>(context).launchHomeScreen();
      },
      onChanged: (value) {
        print(value);
        setState(() {
          pinSet = value;
        });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return false;
      },
      appContext: context,
      validator: (value) => "Huanaf",
    );
  }

  Widget buildRepeatPinCode(BuildContext context) {
    return PinCodeTextField(
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
        // controller: textEditingController,
        onCompleted: (v) {
          print("CompletedRepeat");
          if (pinSet == pinRepeat) {
            BlocProvider.of<LoginCubit>(context).savePinCode(pincode: pinSet!);
            BlocProvider.of<LaunchingCubit>(context).launchHomeScreen();
          }
        },
        onChanged: (value) {
          print(value);
          setState(() {
            pinRepeat = value;
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
          if (pinSet != pinRepeat)
            return "Oba piny muszą być takie same.";
          else
            return null;
        });
  }
}
