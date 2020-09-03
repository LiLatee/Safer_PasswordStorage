import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../utils/constants.dart' as MyConstants;

typedef ToogleEditMode();
typedef ToogleShowPassword();

class ButtonsSection extends StatelessWidget {
  ToogleEditMode toogleEditModeCallback;
  ToogleShowPassword toogleShowPasswordCallback;
  ButtonsSection(
      {Key key, this.toogleEditModeCallback, this.toogleShowPasswordCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("NOWE", name: "LOL");

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonBar(
          children: <Widget>[
            AccountDataTileButton(
              onPressed: () {
                toogleShowPasswordCallback();
              },
              icon: Icon(Icons.remove_red_eye),
              label: 'Show',
              canBePressed: true,
            ),
            AccountDataTileButton(
              onPressed: () {
                toogleEditModeCallback();
              },
              icon: Icon(Icons.edit),
              label: 'Edit',
              canBePressed: true,
            ),
            AccountDataTileButton(
                onPressed: () {},
                icon: Icon(Icons.delete_forever),
                label: 'Remove'),
            AccountDataTileButton(
                onPressed: () {}, icon: Icon(Icons.add), label: 'Add field'),
          ],
        ),
      ],
    );
  }
}

class AccountDataTileButton extends StatefulWidget {
  final Function onPressed;
  final Icon icon;
  final String label;
  final bool canBePressed;
  const AccountDataTileButton({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
    this.canBePressed = false,
  }) : super(key: key);

  @override
  _AccountDataTileButtonState createState() => _AccountDataTileButtonState();
}

class _AccountDataTileButtonState extends State<AccountDataTileButton> {
  Color textColor;
  Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    textColor ??= Theme.of(context).accentColor;
    backgroundColor ??= Theme.of(context).primaryColor;
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(MyConstants.defaultCircularBorderRadius),
        color: backgroundColor,
      ),
      child: FlatButton(
        textColor: textColor,
        onPressed: () {
          setState(() {
            if (widget.canBePressed) {
              // if (textColor == Theme.of(context).accentColor) {
              //   textColor = MyConstants.pressedButtonColor;
              // } else {
              //   textColor = Theme.of(context).accentColor;
              // }

              if (backgroundColor == Theme.of(context).primaryColor) {
                backgroundColor = MyConstants.pressedButtonColor;
              } else {
                backgroundColor = Theme.of(context).primaryColor;
              }
            }

            widget.onPressed();
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
