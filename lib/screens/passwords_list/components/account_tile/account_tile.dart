import 'package:flutter/material.dart';

import '../../../../constants.dart' as constants;
import '../../../../models/account_data.dart';
import '../../../../utils/functions.dart' as functions;
import 'additional_info.dart';
import 'buttons_section.dart';
import 'main_info_section.dart';

class AccountTile extends StatelessWidget {
  AccountTile({Key key, @required this.accountData}) : super(key: key);

  final AccountData accountData;

  @override
  Widget build(BuildContext context) {
    var iconName = accountData.accountName.toLowerCase();

    return Card(
        child: ExpansionTile(
          leading: buildCircleAvatar(iconName),
          title: Text("${accountData.accountName}"),
          children: <Widget>[
            buildExpandedPart(),
          ],
        ),
        color: Theme.of(context).primaryColor);
  }

  Widget buildExpandedPart() {
    return Column(
      children: <Widget>[
        MainInfoSection(accountData: accountData),
        ButtonsSection(),
        accountData.additionalInfo != null
            ? AdditionalInfo(accountData: accountData)
            : Container(),
      ],
    );
  }

  Widget buildCircleAvatar(String iconName) {
    var icon;
    if (constants.availableIconsNames.contains(iconName)) {
      icon = AssetImage('images/${accountData.accountName.toLowerCase()}.png');

      return CircleAvatar(
        backgroundImage: icon,
        backgroundColor: Colors.transparent,
      );
    }
    icon = functions.getDefaultIcon(
        accountName: accountData.accountName, color: Colors.blueGrey);

    return icon;
  }
}
