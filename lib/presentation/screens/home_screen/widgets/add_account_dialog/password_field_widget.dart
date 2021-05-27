import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/constants/AppConstants.dart';

class PasswordFieldWidget extends StatefulWidget {
  final Function onChangedCallback;
  final BuildContext superContext;

  PasswordFieldWidget({
    Key? key,
    required this.onChangedCallback,
    required this.superContext,
  }) : super(key: key);

  @override
  _PasswordFieldWidget createState() => _PasswordFieldWidget();
}

class _PasswordFieldWidget extends State<PasswordFieldWidget> {
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
          textInputAction: TextInputAction.done,
          obscureText: true,
          autofocus: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context)!.password,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          readOnly: false,
          onChanged: (value) {
            widget.onChangedCallback(password: value);
          },
        ),
      ),
    );
  }
}
