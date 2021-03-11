import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;

class AccountButtonTemplate extends StatefulWidget {
  final Function onPressed;
  final Icon icon;
  final String label;
  Color pressedButtonColor;
  final bool canBePressed;

  AccountButtonTemplate({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
    this.pressedButtonColor = Colors.transparent,
    this.canBePressed = false,
  }) : super(key: key);

  @override
  _AccountButtonTemplateState createState() => _AccountButtonTemplateState();
}

class _AccountButtonTemplateState extends State<AccountButtonTemplate> {
  Color textColor;

  @override
  Widget build(BuildContext context) {
    textColor ??= Theme
        .of(context)
        .accentColor;
    widget.pressedButtonColor ??= Theme
        .of(context)
        .primaryColor;
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
          widget.onPressed();
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
