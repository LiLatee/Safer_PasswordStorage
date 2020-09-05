import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/account_expanded_part_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../utils/constants.dart' as MyConstants;

class ButtonsSection extends StatelessWidget {
  ButtonsSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: Provider.of<ExpandedPartBloc>(context).showButtonStream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          Color pressedButtonColor;
          if (snapshot.hasData) {
            if (snapshot.data) {
              pressedButtonColor = MyConstants.pressedButtonColor;
            } else {
              Theme.of(context).accentColor;
            }
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonBar(
                children: <Widget>[
                  AccountDataTileButton(
                    onPressed: () {
                      Provider.of<ExpandedPartBloc>(context, listen: false)
                          .pressShowButton();
                    },
                    icon: Icon(Icons.remove_red_eye),
                    label: 'Show',
                    pressedButtonColor: pressedButtonColor,
                    canBePressed: true,
                  ),
                  AccountDataTileButton(
                    onPressed: () {
                      Provider.of<ExpandedPartBloc>(context, listen: false)
                          .pressEditButton();
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
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      label: 'Add field'),
                ],
              ),
            ],
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
    this.pressedButtonColor,
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
    return Container(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(MyConstants.defaultCircularBorderRadius),
        color: widget.pressedButtonColor,
      ),
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
