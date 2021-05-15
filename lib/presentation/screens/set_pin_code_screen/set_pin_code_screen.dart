import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/core/constants/AppConstants.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/auth_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/launching_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/login_cubit.dart';
import 'package:my_simple_password_storage_clean/presentation/router/app_router.dart';
import 'package:my_simple_password_storage_clean/presentation/screens/login_screen/login_screen.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SetPinCodeScreen extends StatefulWidget {
  @override
  _SetPinCodeScreenState createState() => _SetPinCodeScreenState();
}

class _SetPinCodeScreenState extends State<SetPinCodeScreen>
    with SingleTickerProviderStateMixin {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  TextEditingController textEditingControllerPin = TextEditingController();
  TextEditingController textEditingControllerRepeatPin =
      TextEditingController();

  bool isPinFieldsCompleted = false;
  bool canBeSaved = false;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            buildHelloHeader(context),
            buildPinFields(context),
            buildSetPinButton(context),
            buildRepeatPinFields(context),
            buildnumericKeyboard(context)
          ],
        ),
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
              AppLocalizations.of(context)!.hi,
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
                    AppConstants.pinFieldsWidth / 2 +
                    shakeAnimation.value,
                child: Container(
                  width: AppConstants.pinFieldsWidth,
                  child: AbsorbPointer(
                    // Prevent to show keyboard after cliking on pin field.
                    child: PinCodeTextField(
                      blinkWhenObscuring: true,
                      keyboardType: TextInputType.number,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      length: 4,
                      obscureText: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        activeFillColor:
                            Theme.of(context).colorScheme.background,
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
                      enableActiveFill: true,
                      controller: textEditingControllerPin,
                      onCompleted: (v) async {
                        log('onCompleted');
                        setState(() {
                          isPinFieldsCompleted = true;
                        });
                      },
                      onChanged: (value) {
                        setState(() {});
                      },
                      beforeTextPaste: (text) {
                        return false;
                      },
                      appContext: context,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRepeatPinFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 300.0,
                left: MediaQuery.of(context).size.width / 2 -
                    AppConstants.pinFieldsWidth / 2 +
                    shakeAnimation.value,
                child: Container(
                  width: AppConstants.pinFieldsWidth,
                  child: AbsorbPointer(
                    // Prevent to show keyboard after cliking on pin field.
                    child: PinCodeTextField(
                      blinkWhenObscuring: true,
                      keyboardType: TextInputType.number,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      length: 4,
                      obscureText: true,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        activeFillColor:
                            Theme.of(context).colorScheme.background,
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
                      enableActiveFill: true,
                      controller: textEditingControllerRepeatPin,
                      onCompleted: (v) async {
                        bool samePins = textEditingControllerRepeatPin.text ==
                            textEditingControllerRepeatPin.text;
                        if (samePins) {
                          canBeSaved = true;
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Oba piny muszą byś takie same")));
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
                        bool samePins = textEditingControllerPin.text ==
                            textEditingControllerRepeatPin.text;
                        if (!samePins) {
                          return 'Oba piny muszą byś takie same';
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Positioned buildSetPinButton(BuildContext context) {
    return Positioned(
      top: 380.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              BlocProvider.of<LoginCubit>(context)
                  .savePinCode(pincode: textEditingControllerRepeatPin.text);
              if (BlocProvider.of<LoginCubit>(context).checkIfPinCodeExists())
                Navigator.of(context).pop();
              else
                Navigator.of(context).pushReplacementNamed(AppRouterNames.home);
            },
            child: Text(
              AppLocalizations.of(context)!.setPinCode,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          )
        ],
      ),
    );
  }

  Positioned buildnumericKeyboard(BuildContext context) {
    var textEditingController = isPinFieldsCompleted
        ? textEditingControllerRepeatPin
        : textEditingControllerPin;

    // bool isPinEmpty = textEditingController.text.length == 0;

    var rightIcon = Icon(Icons.arrow_back);

    return Positioned(
      width: MediaQuery.of(context).size.width,
      bottom: 0.0,
      child: NumericKeyboard(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        textColor: Theme.of(context).colorScheme.onBackground,
        rightIcon: rightIcon,
        rightButtonFn: () async {
          setState(() {
            if (textEditingController.text.isEmpty) {
              if (textEditingControllerPin.text.isNotEmpty) {
                textEditingControllerPin.text = textEditingControllerPin.text
                    .substring(0, textEditingControllerPin.text.length - 1);
              }
              setState(() {
                isPinFieldsCompleted = false;
              });
            } else {
              textEditingController.text = textEditingController.text
                  .substring(0, textEditingController.text.length - 1);
            }
          });
        },
        onKeyboardTap: (text) {
          if (textEditingController.text.length < 4)
            textEditingController.text += text;
        },
      ),
    );
  }
}
