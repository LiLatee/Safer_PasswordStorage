import 'package:flutter/material.dart';
import '../../../../../../core/constants/AppConstants.dart' as MyConstants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ButtonTemplate extends StatefulWidget {
  final Function onPressed;
  final Icon icon;
  final String label;
  final Color pressedButtonColor;
  final bool canBePressed;

  ButtonTemplate({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.pressedButtonColor = Colors.transparent,
    this.canBePressed = false,
  }) : super(key: key);

  @override
  _ButtonTemplateState createState() => _ButtonTemplateState();
}

class _ButtonTemplateState extends State<ButtonTemplate> {
  Color? _textColor;

  @override
  Widget build(BuildContext context) {
    _textColor ??= Theme.of(context).accentColor;
    // widget.pressedButtonColor ??= Theme
    //     .of(context)
    //     .primaryColor;

    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(MyConstants.defaultCircularBorderRadius),
        color: widget.pressedButtonColor,
      ),
      duration: MyConstants.animationsDuration,
      child: FlatButton(
        textColor: _textColor,
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
