import 'package:flutter/material.dart';

import '../constants.dart' as Constants;

class MyDialog extends StatelessWidget {
  final Widget content;
  final Widget title;

  const MyDialog({
    Key key,
    @required this.content,
    @required this.title,
  }) : super(key: key);

  Container buildDialogContent() {
    return Container(
      padding: EdgeInsets.only(top: 25.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      margin: EdgeInsets.only(top: 25),
      child: content,
    );
  }

  Positioned buildDialogHeader(BuildContext context) {
    return Positioned(
      left: Constants.defaultPadding,
      right: Constants.defaultPadding,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Theme.of(context).accentColor,
        ),
        height: 50,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Constants.defaultPadding / 4),
            child: title,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.defaultPadding),
      ),
      elevation: 10.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Stack(
              children: <Widget>[
                buildDialogContent(),
                buildDialogHeader(context)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
