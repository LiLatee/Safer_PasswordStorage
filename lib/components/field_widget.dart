import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/constants.dart' as Constants;

// class FieldWidget extends StatelessWidget {
//   const FieldWidget({
//     Key key,
//     @required this.label,
//     this.isSingleLine = false,
//     this.value,
//     this.isPassword = false,
//     this.onChangedCallback,
//     this.readOnly,
//   }) : super(key: key);

//   final bool readOnly;
//   final String label;
//   final bool isSingleLine;
//   final String value;
//   final bool isPassword;
//   final Function onChangedCallback;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//           top: Constants.defaultPadding,
//           left: Constants.defaultPadding,
//           right: Constants.defaultPadding),
//       child: TextFormField(
//         decoration: InputDecoration(
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Theme.of(context).accentColor)),
//             border: OutlineInputBorder(),
//             labelText: label,
//             labelStyle: TextStyle(
//                 color: Theme.of(context).accentColor,
//                 fontWeight: FontWeight.bold)),
//         readOnly: readOnly,
//         keyboardType: TextInputType.multiline,
//         minLines: 1,
//         maxLines: (isSingleLine || isPassword) ? 1 : 5,
//         obscureText: isPassword,
//         initialValue: (value != null) ? value : "",
//         onChanged: (value) {
//           if (onChangedCallback != null) {
//             onChangedCallback(value);
//           }
//         },
//       ),
//     );
//   }
// }

abstract class FieldWidget extends StatelessWidget {
  const FieldWidget({
    Key key,
    @required this.label,
    this.value,
    this.isPassword = false,
    this.onChangedCallback,
    this.readOnly = true,
    this.maxLines,
    this.keyboardType,
  }) : super(key: key);

  final bool readOnly;
  final String label;
  final String value;
  final bool isPassword;
  final Function onChangedCallback;
  final int maxLines;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: ObjectKey(label),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor)),
          border: OutlineInputBorder(),
          labelText: label,
          labelStyle: TextStyle(
              color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold)),
      readOnly: readOnly,
      keyboardType: keyboardType ?? TextInputType.text,
      minLines: 1,
      maxLines: maxLines,
      obscureText: isPassword,
      initialValue: value ?? "",
      onChanged: (value) {
        if (onChangedCallback != null) {
          onChangedCallback(value);
        }
      },
    );
  }
}

class AdditionalFieldWidget extends FieldWidget {
  final bool readOnly;
  final String label;
  final String value;
  final Function onChangedCallback;
  AdditionalFieldWidget({
    Key key,
    @required this.label,
    this.value,
    this.onChangedCallback,
    this.readOnly,
  }) : super(
            key: key,
            label: label,
            value: value,
            onChangedCallback: onChangedCallback,
            readOnly: readOnly,
            maxLines: 1,
            isPassword: false);
}

class PasswordFieldWidget extends FieldWidget {
  final bool readOnly;
  final String label;
  final String value;
  final bool showPassword;
  final Function onChangedCallback;
  PasswordFieldWidget({
    Key key,
    @required this.label,
    this.value,
    this.onChangedCallback,
    this.readOnly,
    this.showPassword = false,
  }) : super(
            key: key,
            label: label,
            value: value,
            onChangedCallback: onChangedCallback,
            readOnly: readOnly,
            maxLines: 1,
            isPassword: !showPassword);
}

class EmailFieldWidget extends FieldWidget {
  final bool readOnly;
  final String label;
  final String value;
  final Function onChangedCallback;
  EmailFieldWidget({
    Key key,
    @required this.label,
    this.value,
    this.onChangedCallback,
    this.readOnly = true,
  }) : super(
            key: key,
            label: label,
            value: value,
            onChangedCallback: onChangedCallback,
            readOnly: readOnly,
            maxLines: 1,
            isPassword: false,
            keyboardType: TextInputType.emailAddress);
}
