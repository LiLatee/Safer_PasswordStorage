import 'dart:developer';

import 'package:flutter/material.dart';
import '../../../../models/account_data.dart';

import 'body_buttons_section.dart';
import 'body_fields_section.dart';
import 'body_fields_section_editable.dart';

typedef void ToogleEditMode({String accountName});
typedef void ToogleShowPassword({String accountName});

class AccountDataExpandedPart extends StatefulWidget {
  final AccountData accountData;
  final bool isEditable;
  final bool showPassword;
  final ToogleEditMode toogleEditModeCallback;
  final ToogleShowPassword toogleShowPasswordCallback;

  AccountDataExpandedPart({
    Key key,
    @required this.accountData,
    @required this.toogleEditModeCallback,
    @required this.isEditable,
    this.showPassword = false,
    @required this.toogleShowPasswordCallback,
  }) : super(key: key);

  @override
  _AccountDataExpandedPartState createState() =>
      _AccountDataExpandedPartState();
}

class _AccountDataExpandedPartState extends State<AccountDataExpandedPart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: widget.isEditable
              ? FieldsSectionEditable(
                  accountData: widget.accountData,
                  showPassword: widget.showPassword,
                )
              : FieldsSection(
                  accountData: widget.accountData,
                  showPassword: widget.showPassword,
                ),
        ),
        ButtonsSection(
          toogleEditModeCallback: () {
            setState(() {
              widget.toogleEditModeCallback(
                  accountName: widget.accountData.accountName);
            });
          },
          toogleShowPasswordCallback: () {
            setState(() {
              widget.toogleShowPasswordCallback(
                  accountName: widget.accountData.accountName);
            });
          },
        ),
      ],
    );
  }
}
