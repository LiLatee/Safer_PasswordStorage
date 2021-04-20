import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/constants/AppConstants.dart' as AppConstants;

class AccountNameFieldWidget extends StatefulWidget {
  final Function onChangedCallback;
  final GlobalKey accountNameFormKey;
  final BuildContext superContext;

  AccountNameFieldWidget({
    Key? key,
    required this.onChangedCallback,
    required this.accountNameFormKey,
    required this.superContext,
  }) : super(key: key);

  @override
  _AccountNameFieldWidgetState createState() => _AccountNameFieldWidgetState();
}

class _AccountNameFieldWidgetState extends State<AccountNameFieldWidget> {
  @override
  Widget build(BuildContext context) {
    // DataProvider dataProvider = Provider.of<DataProvider>(widget.superContext);
    return Container(
      padding: EdgeInsets.only(
          top: AppConstants.defaultPadding,
          left: AppConstants.defaultPadding,
          right: AppConstants.defaultPadding),
      child: Form(
        key: widget.accountNameFormKey,
        autovalidate: true,
        child: TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    // color: Theme.of(context).accentColor,
                    )),
            border: OutlineInputBorder(),
            labelText: AppLocalizations.of(context)!.accountName,
            labelStyle: TextStyle(
              // color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          readOnly: false,
          validator: (value) {
            if (value != null) {
              if (value.isEmpty)
                return AppLocalizations.of(context)!.emptyAccountNameValidator;
              // else if (DataProvider.isAccountNameUsed(name: value))
              //   return AppLocalizations.of(context)!.existAccountNameValidator; // TODO
            }
            return null;
          },
          onChanged: (value) {
            widget.onChangedCallback(accountName: value);
          },
        ),
      ),
    );
  }
}
