import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';

import '../utils/constants.dart' as Constants;

class AccountNameFieldWidget extends StatefulWidget {
  final Function onChangedCallback;
  final List<AccountData> currentAccounts;
  final GlobalKey accountNameFormKey;

  AccountNameFieldWidget(
      {Key key,
      @required this.onChangedCallback,
      @required this.currentAccounts,
      @required this.accountNameFormKey})
      : super(key: key);

  @override
  _AccountNameFieldWidgetState createState() => _AccountNameFieldWidgetState();
}

class _AccountNameFieldWidgetState extends State<AccountNameFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Constants.defaultPadding,
          left: Constants.defaultPadding,
          right: Constants.defaultPadding),
      child: Form(
        key: widget.accountNameFormKey,
        autovalidate: true,
        child: TextFormField(
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor)),
              border: OutlineInputBorder(),
              labelText: 'Account name',
              labelStyle: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold)),
          readOnly: false,
          validator: (value) {
            if (value.isEmpty) {
              return "Name can't be empty.";
            } else if (AccountData.isNameUsed(
                accounts: widget.currentAccounts, name: value)) {
              return 'Name already exists.';
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
