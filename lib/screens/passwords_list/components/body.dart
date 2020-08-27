import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants.dart' as Constants;
import '../../../models/account_data.dart';
import '../../../modified_flutter_widgets/expansion_panel.dart' as epn;
import '../../../utils/functions.dart' as Functions;
import 'account_tile/body_buttons_section.dart';
import 'account_tile/body_fields_section.dart';
import 'account_tile/header.dart';

class Body extends StatefulWidget {
  final List<AccountData> accounts;

  Body({@required this.accounts});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String expandedValue;

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      epn.ExpansionPanelList.radio(
        initialOpenPanelValue: expandedValue,
        expandedHeaderPadding:
            EdgeInsets.only(left: Constants.defaultPadding * 3),
        children: widget.accounts
            .map<epn.ExpansionPanelRadio>(
                (accountData) => buildExpansionPanel(accountData: accountData))
            .toList(),
      ),
    ]);
  }

  epn.ExpansionPanelRadio buildExpansionPanel(
      {@required AccountData accountData}) {
    return epn.ExpansionPanelRadio(
        canTapOnHeader: true,
        value: accountData.accountName,
        headerBuilder: (BuildContext context, bool isExpanded) {
          if (isExpanded) {
            expandedValue = accountData.accountName;
          }

          return AccountTileHeader(
            accountData: accountData,
          );
        },
        body: buildExpandedPart(accountData: accountData));
  }

  Widget buildExpandedPart({AccountData accountData}) {
    return Column(
      children: <Widget>[
        FieldsSection(accountData: accountData),
        ButtonsSection(),
      ],
    );
  }
}
