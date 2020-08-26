import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../constants.dart' as constants;
import '../../../../models/account_data.dart';
import '../../../../utils/functions.dart' as functions;
import '../../../../utils/functions.dart';
import 'body_buttons_section.dart';
import 'body_fields_section.dart';

class AccountTile extends StatefulWidget {
  final AccountData accountData;
  final int index;
  final int selectedTileIndex;
  final Function(int) callback;

  AccountTile({
    Key key,
    @required this.accountData,
    @required this.selectedTileIndex,
    @required this.index,
    @required this.callback,
  }) : super(key: key);

  @override
  _AccountTileState createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return buildTileHeader(context, size);
  }

  Stack buildTileHeader(BuildContext context, Size size) {
    bool isExpanded =
        widget.index.toString() == widget.selectedTileIndex.toString();
    log("selectedTileIndex:${widget.selectedTileIndex.toString()}",
        name: "LOL");
    log("index:${widget.index.toString()}", name: "LOL");
    log("isExpanded:${isExpanded}", name: "LOL");

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(constants.defaultPadding / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(constants.defaultIconRadius),
            // border: Border.all(color: Colors.grey),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                offset: Offset(5, 5),
                color: Colors.grey,
              )
            ],
          ),
          child: Row(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(constants.defaultIconRadius),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5, offset: Offset(0, 0), color: Colors.grey)
                  ],
                ),
                child: widget.accountData.icon,
                // child: buildCircleAvatar(
                //     iconName: accountData.accountName.toLowerCase(),
                //     radius: constants.defaultIconRadius),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, right: size.width * 0.03),
          child: ExpansionTile(
            key: Key(widget.index.toString()),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (isOpened) {
              setState(() {
                if (isOpened) {
                  widget.callback(widget.index);
                } else {
                  widget.callback(-1);
                }
              });
            },
            title: Row(
              children: <Widget>[
                SizedBox(
                  width: constants.defaultIconRadius * 2 +
                      constants.defaultPadding,
                ),
                Text(widget.accountData.accountName)
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
        FieldsSection(accountData: widget.accountData),
        ButtonsSection(),
      ],
    );
  }

  Widget buildCircleAvatar({String iconName, double radius = 25.0}) {
    var icon;
    if (constants.availableIconsNames.contains(iconName)) {
      icon = AssetImage(
          'images/${widget.accountData.accountName.toLowerCase()}.png');

      return CircleAvatar(
        radius: radius,
        backgroundImage: icon,
        backgroundColor: Colors.transparent,
      );
    }
    icon = functions.generateDefaultIcon(
        accountName: widget.accountData.accountName, radius: radius);

    return icon;
  }
}
