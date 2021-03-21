import 'dart:developer';

import 'package:flutter/material.dart';

import '../utils/constants.dart' as Constants;

typedef onChangeText({required String newText});
// class FieldWidget extends StatelessWidget {
//   const FieldWidget({
//     Key key,
//     required this.label,
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

class FieldWidget extends StatelessWidget {
  const FieldWidget(
      {Key? key,
      required this.label,
      this.value = "",
      this.isPassword = false,
      this.readOnly = true,
      this.maxLines = 1,
      this.textInputType = TextInputType.text,
      this.onChangedCallback,
      this.onEditingComplete,
      this.textInputAction = TextInputAction.done,
      this.onFieldSubmitted,
      this.multiline = false,
      this.hiddenValue = false})
      : super(key: key);

  final bool readOnly;
  final String label;
  final String value;
  final bool isPassword;
  final onChangeText? onChangedCallback;
  final int? maxLines;
  final TextInputType textInputType;
  final Function? onEditingComplete;
  final onChangeText? onFieldSubmitted;
  final TextInputAction textInputAction;
  final bool multiline;
  final bool hiddenValue;

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
            color: Theme.of(context).accentColor, fontWeight: FontWeight.bold),
      ),
      readOnly: readOnly,
      keyboardType: textInputType,
      minLines: 1,
      maxLines: multiline == true ? null : 1,
      obscureText: hiddenValue,
      enableInteractiveSelection: true,
      initialValue: value,
      onChanged: (value) {
        if (onChangedCallback != null) onChangedCallback!(newText: value);
      },
      onEditingComplete: () {
        if (onEditingComplete != null) onEditingComplete!();
      },
      onFieldSubmitted: (value) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted!(newText: value);
          FocusScope.of(context).unfocus();
        }
      },
      textInputAction: textInputAction,
    );
  }
}

class AdditionalFieldWidget extends FieldWidget {
  final bool readOnly;
  final String label;
  final String value;
  final onChangeText? onChangedCallback;
  final Function? onEditingComplete;
  final TextInputAction textInputAction;
  final onChangeText? onFieldSubmitted;
  final bool hiddenValue;
  final bool multiline;
  final TextInputType textInputType;

  AdditionalFieldWidget({
    Key? key,
    required this.label,
    this.value = "",
    this.onChangedCallback,
    this.readOnly = false,
    this.onEditingComplete,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
    this.hiddenValue = false,
    this.multiline = false,
    this.textInputType = TextInputType.text,
  }) : super(
          key: key,
          label: label,
          value: value,
          onChangedCallback: onChangedCallback,
          readOnly: readOnly,
          maxLines: multiline ? null : 1,
          isPassword: hiddenValue,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: textInputAction,
          textInputType: textInputType,
        );
}

class PasswordFieldWidget extends FieldWidget {
  final bool readOnly;
  final String label;
  final String value;
  final bool showPassword;
  final onChangeText? onChangedCallback;
  final onChangeText? onFieldSubmitted;
  final Function? onEditingComplete;

  PasswordFieldWidget({
    Key? key,
    required this.label,
    this.value = '',
    this.onChangedCallback,
    this.readOnly = true,
    this.showPassword = false,
    this.onEditingComplete,
    this.onFieldSubmitted,
  }) : super(
          key: key,
          label: label,
          value: value,
          onChangedCallback: onChangedCallback,
          readOnly: readOnly,
          maxLines: 1,
          isPassword: !showPassword,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
        );
}

class EmailFieldWidget extends FieldWidget {
  final bool readOnly;
  final String label;
  final String value;
  final onChangeText? onChangedCallback;
  final Function? onEditingComplete;
  final onChangeText? onFieldSubmitted;

  EmailFieldWidget({
    Key? key,
    required this.label,
    this.value = '',
    this.onChangedCallback,
    this.readOnly = true,
    this.onEditingComplete,
    this.onFieldSubmitted,
  }) : super(
          key: key,
          label: label,
          value: value,
          onChangedCallback: onChangedCallback,
          readOnly: readOnly,
          maxLines: 1,
          isPassword: false,
          textInputType: TextInputType.emailAddress,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
        );
}
