import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/constants/AppConstants.dart';
import '../../../logic/cubit/general/login_cubit.dart';
import '../../router/app_router.dart';
import '../login_screen/login_screen.dart';

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
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  // alignment: Alignment.center,
                  children: [
                    buildHelloHeader(context),
                  ],
                ),
              ),
            ),
            // Spacer(),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  buildPinFields(context),
                  buildRepeatPinFields(context),
                  buildSetPinButton(context),
                  buildnumericKeyboard(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column buildHelloHeader(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30.0),
        AppConstants.iconWidget,
        SizedBox(height: 10.0),
        Text(
          AppConstants.appName,
          style: Theme.of(context).textTheme.headline3!.copyWith(
                color: Theme.of(context).colorScheme.secondaryVariant,
              ),
        ),
        SizedBox(height: 30.0),
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
                  activeFillColor: Theme.of(context).colorScheme.background,
                  inactiveColor: Colors.red,
                  activeColor: Colors.green,
                  disabledColor: Colors.white,
                  selectedColor: Colors.blue,
                  selectedFillColor: Theme.of(context).colorScheme.background,
                  inactiveFillColor: Theme.of(context).colorScheme.background,
                ),
                animationDuration: Duration(milliseconds: 300),
                textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                enableActiveFill: true,
                controller: textEditingControllerPin,
                onCompleted: (v) async {
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
    );
  }

  Widget buildRepeatPinFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
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
                  activeFillColor: Theme.of(context).colorScheme.background,
                  inactiveColor: Colors.red,
                  activeColor: Colors.green,
                  disabledColor: Colors.white,
                  selectedColor: Colors.blue,
                  selectedFillColor: Theme.of(context).colorScheme.background,
                  inactiveFillColor: Theme.of(context).colorScheme.background,
                ),
                animationDuration: Duration(milliseconds: 300),
                textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                enableActiveFill: true,
                controller: textEditingControllerRepeatPin,
                onCompleted: (v) async {
                  bool samePins = textEditingControllerPin.text ==
                      textEditingControllerRepeatPin.text;
                  if (samePins) {
                    canBeSaved = true;
                  }
                  // else {
                  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       content: Text(AppLocalizations.of(context)!.pinsMustBeSame)));
                  // }
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
                    return AppLocalizations.of(context)!.pinsMustBeSame;
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSetPinButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            if (canBeSaved) {
              BlocProvider.of<LoginCubit>(context)
                  .savePinCode(pincode: textEditingControllerRepeatPin.text);
              Navigator.of(context).pushReplacementNamed(AppRouterNames.home);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(AppLocalizations.of(context)!.pinsMustBeSame)));
            }
          },
          child: Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0))),
            child: Text(
              AppLocalizations.of(context)!.setPinCode,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        )
      ],
    );
  }

  Widget buildnumericKeyboard(BuildContext context) {
    var textEditingController = isPinFieldsCompleted
        ? textEditingControllerRepeatPin
        : textEditingControllerPin;

    // bool isPinEmpty = textEditingController.text.length == 0;

    var rightIcon = Icon(Icons.arrow_back);

    return Row(
      children: [
        Expanded(
          child: NumericKeyboard(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textColor: Theme.of(context).colorScheme.onBackground,
            rightIcon: rightIcon,
            rightButtonFn: () async {
              setState(() {
                if (textEditingController.text.isEmpty) {
                  if (textEditingControllerPin.text.isNotEmpty) {
                    textEditingControllerPin.text = textEditingControllerPin
                        .text
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
        ),
      ],
    );
  }
}
