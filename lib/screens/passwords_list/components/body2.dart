import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/account_data.dart';
import 'account_tile/account_tile.dart';
import '../../../constants.dart' as Constants;
import '../../../utils/functions.dart' as Functions;
import 'account_tile/buttons_section.dart';
import 'account_tile/fields_section.dart';

class Body2 extends StatefulWidget {
  final List<AccountData> testAccounts;

  Body2({@required this.testAccounts});

  @override
  _Body2State createState() => _Body2State();
}

class _Body2State extends State<Body2> {
  Widget buildExpandedPart({AccountData accountData}) {
    return Column(
      children: <Widget>[
        FieldsSection(accountData: accountData),
        ButtonsSection(),
      ],
    );
  }

  Widget buildCircleAvatar(
      {String iconName, double radius = 25.0, AccountData accountData}) {
    var icon;
    if (Constants.availableIconsNames.contains(iconName)) {
      icon = AssetImage('images/${accountData.accountName.toLowerCase()}.png');

      return CircleAvatar(
        radius: radius,
        backgroundImage: icon,
        backgroundColor: Colors.transparent,
      );
    }
    icon = Functions.generateDefaultIcon(
        accountName: accountData.accountName, radius: radius);

    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      ExpansionPanelList.radio(
        // initialOpenPanelValue: 0,
        children: widget.testAccounts
            .map<ExpansionPanelRadio>(
                (accountData) => buildExpansionPanel(accountData: accountData))
            .toList(),
      ),
    ]);
  }

  Widget buildTileHeader({@required AccountData accountData}) {
    return Container(
      margin: EdgeInsets.all(Constants.defaultPadding / 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.defaultIconRadius),
        color: Theme.of(context).cardColor,
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 5,
        //     offset: Offset(5, 5),
        //     color: Colors.grey,
        //   )
        // ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.defaultIconRadius),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5, offset: Offset(0, 0), color: Colors.grey)
              ],
            ),
            child: accountData.icon,
            // child: buildCircleAvatar(
            //     iconName: accountData.accountName.toLowerCase(),
            //     radius: constants.defaultIconRadius),
          ),
          Text(accountData.accountName),
        ],
      ),
    );
  }

  ExpansionPanelRadio buildExpansionPanel({@required AccountData accountData}) {
    return ExpansionPanelRadio(
        canTapOnHeader: true,
        value: accountData.accountName,
        headerBuilder: (BuildContext context, bool isExpanded) {
          return Container(
            child: Stack(children: <Widget>[
              Container(
                  margin: EdgeInsets.all(Constants.defaultPadding / 2),
                  decoration: BoxDecoration(
                    // border: Border.all(),
                    borderRadius:
                        BorderRadius.circular(Constants.defaultIconRadius),
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        offset: Offset(5, 5),
                        color: Colors.grey,
                      )
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              Constants.defaultIconRadius),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                offset: Offset(0, 0),
                                color: Colors.grey)
                          ],
                        ),
                        child: accountData.icon,
                        // child: buildCircleAvatar(
                        //     iconName: accountData.accountName.toLowerCase(),
                        //     radius: constants.defaultIconRadius),
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text(accountData.accountName)
                    ],
                  )),
            ]),
          );
        },
        body: Container(
          child: buildExpandedPart(accountData: accountData),
        ));
  }
}
