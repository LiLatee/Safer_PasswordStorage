import 'package:flutter/material.dart';

import '../../../../../../core/constants/AppConstants.dart';

class ButtonTemplate extends StatefulWidget {
  final Function()? onPressed;
  final IconData icon;
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
  // Color? _textColor;

  @override
  Widget build(BuildContext context) {
    // _textColor ??= Theme.of(context).accentColor;
    // widget.pressedButtonColor ??= Theme
    //     .of(context)
    //     .primaryColor;

    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(AppConstants.defaultCircularBorderRadius),
        color: widget.pressedButtonColor,
      ),
      duration: AppConstants.animationsDuration,
      child: Opacity(
        opacity: widget.onPressed == null ? 0.38 : 1.0,
        child: TextButton(
          // textColor: _textColor,
          onPressed: widget.onPressed == null ? null : widget.onPressed,
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    widget.icon,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  Text(
                    widget.label,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
