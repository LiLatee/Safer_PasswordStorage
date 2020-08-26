import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart' as Constants;
import '../../../models/account_data.dart';
import '../../../modified_flutter_widgets/expansion_panel.dart' as epn;
import '../../../utils/functions.dart' as Functions;
import 'account_tile/body_buttons_section.dart';
import 'account_tile/body_fields_section.dart';
import 'account_tile/header.dart';

class Body2 extends StatefulWidget {
  final List<AccountData> accounts;

  Body2({@required this.accounts});

  @override
  _Body2State createState() => _Body2State();
}

class _Body2State extends State<Body2> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      epn.ExpansionPanelList.radio(
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
        value: UniqueKey(),
        headerBuilder: (BuildContext context, bool isExpanded) {
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
