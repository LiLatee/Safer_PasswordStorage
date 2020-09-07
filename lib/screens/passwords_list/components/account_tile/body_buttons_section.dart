import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/account_expanded_part_bloc.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart' as MyConstants;

class ButtonsSection extends StatelessWidget {
  ButtonsSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(MyConstants.defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  MyConstants.defaultCircularBorderRadius),
              color: Theme.of(context).secondaryHeaderColor,
            ), // TODO
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                buildShowButton(context),
                buildEditButton(context),
                AccountDataTileButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete_forever),
                    label: 'Remove'),
                AccountDataTileButton(
                    onPressed: () {
                      ExpandedPartBloc expandedPartBloc =
                          Provider.of<ExpandedPartBloc>(context, listen: false);
                      if (expandedPartBloc.editButtonState ==
                          MyConstants.ButtonState.unpressed) {
                        expandedPartBloc.pressEditButton();
                      }

                      AccountData account =
                          Provider.of<AccountData>(context, listen: false);
                      account.addField(
                          name: "Siemanko", value: "taka se wartość");

                      account.listKey.currentState.insertItem(
                          account.getNumberOfFields - 1,
                          duration: MyConstants.animationsDuration);
                    },
                    icon: Icon(Icons.add),
                    label: 'Add field'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  StreamBuilder<MyConstants.ButtonState> buildEditButton(BuildContext context) {
    return StreamBuilder<MyConstants.ButtonState>(
        stream: Provider.of<ExpandedPartBloc>(context).editButtonStream,
        builder: (context, snapshot) {
          return AccountDataTileButton(
            onPressed: () {
              Provider.of<ExpandedPartBloc>(context, listen: false)
                  .pressEditButton();
            },
            icon: Icon(Icons.edit),
            label: 'Edit',
            pressedButtonColor:
                snapshot.data == MyConstants.ButtonState.pressed ?? false
                    ? MyConstants.pressedButtonColor
                    : Colors.transparent,
            canBePressed: true,
          );
        });
  }

  StreamBuilder<bool> buildShowButton(BuildContext context) {
    return StreamBuilder<bool>(
        stream: Provider.of<ExpandedPartBloc>(context).showButtonStream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return AccountDataTileButton(
            onPressed: () {
              Provider.of<ExpandedPartBloc>(context, listen: false)
                  .pressShowButton();
            },
            icon: Icon(Icons.remove_red_eye),
            label: 'Show',
            pressedButtonColor: snapshot.data ?? false
                ? MyConstants.pressedButtonColor
                : Colors.transparent,
            canBePressed: true,
          );
        });
  }
}

class AccountDataTileButton extends StatefulWidget {
  final Function onPressed;
  final Icon icon;
  final String label;
  Color pressedButtonColor;
  final bool canBePressed;
  AccountDataTileButton({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
    this.pressedButtonColor = Colors.transparent,
    this.canBePressed = false,
  }) : super(key: key);

  @override
  _AccountDataTileButtonState createState() => _AccountDataTileButtonState();
}

class _AccountDataTileButtonState extends State<AccountDataTileButton> {
  Color textColor;

  @override
  Widget build(BuildContext context) {
    textColor ??= Theme.of(context).accentColor;
    widget.pressedButtonColor ??= Theme.of(context).primaryColor;
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(MyConstants.defaultCircularBorderRadius),
        color: widget.pressedButtonColor,
      ),
      duration: MyConstants.animationsDuration,
      child: FlatButton(
        textColor: textColor,
        onPressed: () {
          setState(() {
            widget.onPressed();
            // if (widget.canBePressed) {
            //   // if (textColor == Theme.of(context).accentColor) {
            //   //   textColor = MyConstants.pressedButtonColor;
            //   // } else {
            //   //   textColor = Theme.of(context).accentColor;
            //   // }
            //   if (widget.backgroundColor == Theme.of(context).primaryColor) {
            //     widget.backgroundColor = MyConstants.pressedButtonColor;
            //   } else {
            //     widget.backgroundColor = Theme.of(context).primaryColor;
            //   }
            // }

            // widget.onPressed();
          });
        },
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[widget.icon, Text(widget.label)],
            ),
          ],
        ),
      ),
    );
  }
}
