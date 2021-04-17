import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../core/constants/AppConstants.dart' as AppConstants;

class MyDialog extends StatelessWidget {
  final Widget _content;
  final String _title;
  final List<Widget>? _buttons;

  const MyDialog({
    Key? key,
    required title,
    required content,
    buttons,
  })  : _content = content,
        _title = title,
        _buttons = buttons ?? const <Widget>[],
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultPadding),
      ),
      elevation: 10.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                _buttons != null ? buildDialogContent(_buttons!) : Container(),
                buildDialogHeader(context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDialogContent(List<Widget>? buttons) {
    return Container(
      padding: EdgeInsets.only(top: AppConstants.defaultCircularBorderRadius),
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(AppConstants.defaultCircularBorderRadius),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: AppConstants.defaultCircularBorderRadius),
      child: Column(
        children: [
          _content,
          ButtonBar(
            children: buttons ?? [],
          ),
        ],
      ),
    );
  }

  Widget buildDialogHeader(BuildContext context) {
    return Positioned(
      left: AppConstants.defaultPadding,
      right: AppConstants.defaultPadding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Theme.of(context).accentColor,
        ),
        height: 50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding / 4),
            child: AutoSizeText(
              _title,
              style: Theme.of(context).textTheme.headline2,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class MyDialogButton extends StatelessWidget {
  const MyDialogButton({
    Key? key,
    required this.buttonName,
    this.onPressed,
  }) : super(key: key);

  final String buttonName;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      splashColor: AppConstants.pressedButtonColor,
      child: Container(
        child: Text(
          buttonName,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }
}
