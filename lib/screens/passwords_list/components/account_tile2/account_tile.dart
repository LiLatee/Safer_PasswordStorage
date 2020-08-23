import 'package:flutter/material.dart';
import '../../../../models/account_data.dart';
import '../../../../utils/functions.dart';
import '../../../../constants.dart' as constants;
import '../../../../utils/functions.dart' as functions;
import 'additional_info.dart';
import 'buttons_section.dart';
import 'main_info_section.dart';

class AccountTile extends StatelessWidget {
  final AccountData accountData;

  AccountTile({Key key, @required this.accountData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey,
            boxShadow: [BoxShadow(blurRadius: 5, offset: Offset(5, 5))],
          ),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(blurRadius: 5, offset: Offset(5, 5))
                    ]),
                child: buildCircleAvatar(
                    iconName: accountData.accountName.toLowerCase(),
                    radius: 25.0),
              ),
              Expanded(
                child: Container(),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15, right: 20),
          child: ExpansionTile(
            title: Row(
              children: <Widget>[
                SizedBox(
                  width: 70,
                ),
                Text(accountData.accountName)
              ],
            ),
            children: <Widget>[buildExpandedPart()],
          ),
        ),
      ],
    );
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

  Widget buildCircleAvatar({String iconName, double radius = 25.0}) {
    var icon;
    if (constants.availableIconsNames.contains(iconName)) {
      icon = AssetImage('images/${accountData.accountName.toLowerCase()}.png');

      return CircleAvatar(
        radius: radius,
        backgroundImage: icon,
        backgroundColor: Colors.transparent,
      );
    }
    icon = functions.getDefaultIcon(
        accountName: accountData.accountName,
        color: Colors.blueGrey, // TODO
        radius: radius);

    return icon;
  }
}
