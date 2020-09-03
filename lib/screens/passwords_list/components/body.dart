import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/account_data.dart';
import '../../../modified_flutter_widgets/expansion_panel.dart' as epn;
import '../../../utils/constants.dart' as MyConstants;
import 'account_tile/body_buttons_section.dart';
import 'account_tile/body_fields_section.dart';
import 'account_tile/header.dart';
import 'account_tile/account_data_expanded_part.dart';

class Body extends StatefulWidget {
  final List<AccountData> accounts;

  Body({@required this.accounts});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // List<bool> isExpandedList;
  Map<String, bool> isEditableMap;
  Map<String, bool> showPasswordMap;
  @override
  Widget build(BuildContext context) {
    // isExpandedList ??= List.filled(widget.accounts.length, false);
    isEditableMap ??= Map.fromIterables(
        widget.accounts.map((e) => e.accountName),
        List.filled(widget.accounts.length, false));

    showPasswordMap ??= Map.fromIterables(
        widget.accounts.map((e) => e.accountName),
        List.filled(widget.accounts.length, false));

    return ListView(children: <Widget>[
      epn.ExpansionPanelList.radio(
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            // Expanded/Collapsed tile, so turn off edit mode and hide password everywhere.
            isEditableMap = Map.fromIterables(
                widget.accounts.map((e) => e.accountName),
                List.filled(widget.accounts.length, false));

            showPasswordMap = Map.fromIterables(
                widget.accounts.map((e) => e.accountName),
                List.filled(widget.accounts.length, false));

            // bool temp = !isExpandedList[panelIndex];
            // isExpandedList[panelIndex] = !isExpanded && temp;
          });
        },
        expandedHeaderPadding:
            EdgeInsets.only(left: MyConstants.defaultPadding * 3),
        children: widget.accounts.map((accountData) {
          return buildExpansionPanel(
              accountData: accountData,
              isEditable: isEditableMap[accountData.accountName],
              showPassword: showPasswordMap[accountData.accountName]);
        }).toList(),
      ),
    ]);
  }

  epn.ExpansionPanelRadio buildExpansionPanel(
      {@required AccountData accountData,
      @required bool isEditable,
      @required bool showPassword}) {
    return epn.ExpansionPanelRadio(
        canTapOnHeader: true,
        value: accountData.accountName,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return AccountTileHeader(
            accountData: accountData,
          );
        },
        body: AccountDataExpandedPart(
          accountData: accountData,
          isEditable: isEditable,
          toogleEditModeCallback: ({accountName}) {
            toogleEditMode(accountName: accountName);
          },
          showPassword: showPassword,
          toogleShowPasswordCallback: ({accountName}) {
            toogleShowPassword(accountName: accountName);
          },
        ));
  }

  void toogleEditMode({String accountName}) {
    setState(() {
      isEditableMap[accountName] = !isEditableMap[accountName];
    });
  }

  void toogleShowPassword({String accountName}) {
    setState(() {
      showPasswordMap[accountName] = !showPasswordMap[accountName];
    });
  }
}
