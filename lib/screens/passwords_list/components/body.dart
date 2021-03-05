import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:provider/provider.dart';

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
  @override
  Widget build(BuildContext context) {
    return epn.ExpansionPanelList.radio(
      expandedHeaderPadding:
          EdgeInsets.only(left: MyConstants.defaultPadding * 3),
      children: widget.accounts.map(
        (accountDataEntity) {
          return buildExpansionPanel(
            accountDataEntity: accountDataEntity,
          );
        },
      ).toList(),
    );

    // return ListView(
    //   scrollDirection: Axis.vertical,
    //   shrinkWrap: true,
    //   children: <Widget>[
    //     epn.ExpansionPanelList.radio(
    //       expansionCallback: (panelIndex, isExpanded) {
    //         setState(() {
    //           // bool temp = !isExpandedList[panelIndex];
    //           // isExpandedList[panelIndex] = !isExpanded && temp;
    //         });
    //       },
    //       expandedHeaderPadding:
    //           EdgeInsets.only(left: MyConstants.defaultPadding * 3),
    //       children: widget.accounts.map(
    //         (accountDataEntity) {
    //           return buildExpansionPanel(
    //             accountDataEntity: accountDataEntity,
    //           );
    //         },
    //       ).toList(),
    //     ),
    //   ],
    // );
  }

  epn.ExpansionPanelRadio buildExpansionPanel(
      {@required AccountDataEntity accountDataEntity}) {
    return epn.ExpansionPanelRadio(
      canTapOnHeader: true,
      value: accountDataEntity.id,
      headerBuilder: (BuildContext context, bool isExpanded) {
        // return Text("${accountDataEntity.accountName}");
        return Provider.value(
          value: accountDataEntity,
          child: AccountTileHeader(),
        );
      },
      body: Provider.value(
        value: accountDataEntity,
        child: AccountDataExpandedPart(),
      ),
    );
  }
}
