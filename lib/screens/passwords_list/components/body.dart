import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';

import '../../../models/account_data.dart';
import '../../../modified_flutter_widgets/expansion_panel.dart' as epn;
import '../../../utils/constants.dart' as MyConstants;
import 'account_tile/expanded_part/account_data_expanded_part.dart';
import 'account_tile/header.dart';

class Body extends StatefulWidget {
  final List<AccountDataEntity> accounts;

  Body({@required this.accounts});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // List<bool> isExpandedList;

  @override
  Widget build(BuildContext context) {
    // isExpandedList ??= List.filled(widget.accounts.length, false);

    return ListView(children: <Widget>[
      epn.ExpansionPanelList.radio(
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            // bool temp = !isExpandedList[panelIndex];
            // isExpandedList[panelIndex] = !isExpanded && temp;
          });
        },
        expandedHeaderPadding:
            EdgeInsets.only(left: MyConstants.defaultPadding * 3),
        children: widget.accounts.map((accountData) {
          return buildExpansionPanel(
            accountData: accountData,
          );
        }).toList(),
      ),
    ]);
  }

  epn.ExpansionPanelRadio buildExpansionPanel(
      {@required AccountDataEntity accountData}) {
    return epn.ExpansionPanelRadio(
        canTapOnHeader: true,
        value: accountData.id,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return AccountTileHeader(
            accountData: accountData,
          );
        },
        body: AccountDataExpandedPart(
          accountData: accountData,
        ));
  }
}
