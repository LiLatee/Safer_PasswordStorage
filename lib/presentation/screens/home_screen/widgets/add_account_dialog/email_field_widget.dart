import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/constants/AppConstants.dart';

class EmailFieldWidget extends StatefulWidget {
  final Function onChangedCallback;
  final BuildContext superContext;

  EmailFieldWidget({
    Key? key,
    required this.onChangedCallback,
    required this.superContext,
  }) : super(key: key);

  @override
  _EmailFieldWidget createState() => _EmailFieldWidget();
}

class _EmailFieldWidget extends State<EmailFieldWidget> {
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
            labelText: AppLocalizations.of(context)!.email,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          readOnly: false,
          validator: (value) => EmailValidator.validate(value!)

              /// Not used
              ? null
              : AppLocalizations.of(context)!.notAnEmail,
          onChanged: (value) {
            widget.onChangedCallback(email: value);
          },
        ),
      ),
    );
  }
}
