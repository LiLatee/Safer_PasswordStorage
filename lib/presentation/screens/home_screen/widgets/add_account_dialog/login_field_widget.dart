import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/constants/AppConstants.dart';

class LoginFieldWidget extends StatefulWidget {
  final Function onChangedCallback;
  final BuildContext superContext;

  LoginFieldWidget({
    Key? key,
    required this.onChangedCallback,
    required this.superContext,
  }) : super(key: key);

  @override
  _LoginFieldWidget createState() => _LoginFieldWidget();
}

class _LoginFieldWidget extends State<LoginFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: AppConstants.defaultPadding,
        left: AppConstants.defaultPadding,
        right: AppConstants.defaultPadding,
      ),
      child: Form(
        // autovalidate: true,
        child: TextFormField(
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context)!.login,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          readOnly: false,
          onChanged: (value) {
            widget.onChangedCallback(login: value);
          },
        ),
      ),
    );
  }
}
