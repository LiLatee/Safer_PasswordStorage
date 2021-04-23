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
      // elevation: .0,
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(AppConstants.defaultCircularBorderRadius),
      ),
      // decoration: BoxDecoration(
      //   borderRadius:
      //       BorderRadius.circular(AppConstants.defaultCircularBorderRadius),
      //   color: Colors.white,
      // ),
      // color: Colors.transparent,
      elevation: 24,
      margin: EdgeInsets.only(top: AppConstants.defaultCircularBorderRadius),
      child: Padding(
        padding: EdgeInsets.only(top: AppConstants.defaultCircularBorderRadius),
        child: Column(
          children: [
            _content,
            ButtonBar(
              children: buttons ?? [],
            ),
          ],
        ),
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
          color: Theme.of(context).colorScheme.primary,
        ),
        height: 50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.defaultPadding / 4),
            child: AutoSizeText(
              _title,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
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
    return TextButton(
      onPressed: onPressed,
      // splashColor: Theme.of(context).colorScheme.secondary,
      child: Text(
        buttonName.toUpperCase(),
        // style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
