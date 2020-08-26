import 'package:flutter/material.dart';
import '../constants.dart' as Constants;

class FieldWidget extends StatelessWidget {
  const FieldWidget({
    Key key,
    @required this.label,
    this.isPassword = false,
    this.value,
  }) : super(key: key);

  final String label;
  final String value;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Constants.defaultPadding / 2,
          left: Constants.defaultPadding / 2,
          right: Constants.defaultPadding / 2),
      child: TextFormField(
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).accentColor)),
            border: OutlineInputBorder(),
            labelText: label,
            labelStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold)),
        readOnly: false,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: isPassword ? 1 : 5,
        obscureText: isPassword,
        initialValue: (value != null) ? value : "",
      ),
    );
  }
}
