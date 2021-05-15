import 'dart:async';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/core/constants/AppConstants.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/auth_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/launching_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/login_cubit.dart';
import 'package:my_simple_password_storage_clean/presentation/router/app_router.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) => math.sin(t * math.pi * 2.5);
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingController = TextEditingController();

  bool wasBiometricShowed = false;
  bool isAuthenticated = false;

  final double pinFieldsWidth = 300.0;
  late AnimationController animationController;
  late Animation shakeAnimation;
  late CurvedAnimation curve;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    curve = CurvedAnimation(parent: animationController, curve: ShakeCurve());
    shakeAnimation = Tween<double>(begin: -5.0, end: 5.0).animate(curve);
    animationController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    log("LoginScreen - didChangeDependencies");

    if ((!wasBiometricShowed) &&
        (BlocProvider.of<AuthCubit>(context).state is BiometricOn)) {
      isAuthenticated = await BlocProvider.of<AuthCubit>(context)
          .authenticateWithBiometricsIfOn(context: context);
      wasBiometricShowed = true;
    }

    if (isAuthenticated)
      Navigator.of(context).pushReplacementNamed(AppRouterNames.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildHelloHeader(context),
            buildPinFields(context),
            buildnumericKeyboard(context)
          ],
        ),
      ),
    );
  }

  Positioned buildnumericKeyboard(BuildContext context) {
    bool isPinEmpty = textEditingController.text.length == 0;
    bool isBiometricOn =
        BlocProvider.of<AuthCubit>(context).state is BiometricOn;

    var rightIcon = (isPinEmpty && isBiometricOn)
        ? Icon(Icons.fingerprint)
        : Icon(Icons.arrow_back);

    return Positioned(
      width: MediaQuery.of(context).size.width,
      bottom: 0.0,
      child: NumericKeyboard(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textColor: Theme.of(context).colorScheme.onBackground,
        rightIcon: rightIcon,
        rightButtonFn: () async {
          if (isPinEmpty && isBiometricOn) {
            BlocProvider.of<AuthCubit>(context)
                .authenticateWithBiometricsIfOn(context: context)
                .then((value) {
              setState(() {
                isAuthenticated = value;
                if (isAuthenticated)
                  Navigator.of(context)
                      .pushReplacementNamed(AppRouterNames.home);
              });
            });
          } else {
            setState(() {
              textEditingController.text = textEditingController.text
                  .substring(0, textEditingController.text.length - 1);
            });
          }
        },
        onKeyboardTap: (text) {
          textEditingController.text += text;
        },
      ),
    );
  }

  Column buildHelloHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.0),
        Icon(
          Icons.apps,
          size: 70.0,
        ), // TODO app icon
        SizedBox(height: 50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Cześć!",
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        ),
        SizedBox(height: 30.0),
      ],
    );
  }

  Widget buildPinFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 220,
                left: MediaQuery.of(context).size.width / 2 -
                    pinFieldsWidth / 2 +
                    shakeAnimation.value,
                child: Container(
                  width: pinFieldsWidth,
                  // margin: EdgeInsets.symmetric(
                  //     horizontal: AppConstants.defaultToScreenEdgePadding),
                  child: PinCodeTextField(
                    blinkWhenObscuring: true,
                    keyboardType: TextInputType.number,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    length: 4,
                    obscureText: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      activeFillColor: Theme.of(context).colorScheme.background,
                      inactiveColor: Colors.red,
                      activeColor: Colors.green,
                      disabledColor: Colors.white,
                      selectedColor: Colors.blue,
                      selectedFillColor:
                          Theme.of(context).colorScheme.background,
                      inactiveFillColor:
                          Theme.of(context).colorScheme.background,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    textStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground),
                    // backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    controller: textEditingController,
                    onCompleted: (v) async {
                      print("Completed");
                      if (BlocProvider.of<LoginCubit>(context)
                          .checkPinCode(pincode: textEditingController.text)) {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRouterNames.home);
                      } else {
                        await animationController.forward();
                        animationController.reset();
                        textEditingController.text = '';
                      }
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                    beforeTextPaste: (text) {
                      return false;
                    },
                    appContext: context,
                    validator: (value) {
                      bool isInvalidPin = !BlocProvider.of<LoginCubit>(context)
                          .checkPinCode(pincode: textEditingController.text);

                      if ((value!.length == 4) && (isInvalidPin)) {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text("Nieprawidłowy pin")));

                        return 'Nieprawidłowy pin';
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
