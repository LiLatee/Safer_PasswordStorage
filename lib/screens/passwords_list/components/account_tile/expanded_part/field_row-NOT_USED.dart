// /// NOTE:
// /// Cannot update list of fields properly after removing field.
// import 'dart:developer';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import 'package:mysimplepasswordstorage/models/account_data.dart';
// import 'package:mysimplepasswordstorage/utils/AppConstants.dart' as MyConstants;
// import 'field_edit_section.dart';
//
// class FieldRowWithButtons extends StatelessWidget {
//   FieldRowWithButtons({
//     Key key,
//     required this.fieldIndexInAccount,
//     required this.fieldWidget,
//     this.removeField,
//     // required this.buildItem,
//   }) : super(key: key);
//
//   final int fieldIndexInAccount;
//   final Widget fieldWidget;
//   final removeField;
//
//   final Duration _duration = MyConstants.animationsDuration * 2;
//   double _width;
//   double _right;
//
//   // final Function buildItem;
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     _width ??= size.width;
//     _right ??= -3 * MyConstants.defaultIconRadius * 1.5;
//     AccountData accountData = Provider.of<AccountData>(context);
//     Curve curve = Curves.easeInOutBack;
//
//     // Do not show edit actions IF edit button is not pressed.
//     if (!accountData.isEditButtonPressed) {
//       // curve = Curves.easeInBack;
//       _right = -3 * MyConstants.defaultIconRadius * 1.5;
//       _width = size.width;
//     } else if (accountData.isEditButtonPressed) {
//       // curve = Curves.easeOutBack;
//       _right = 0;
//       _width = size.width -
//           MyConstants.defaultIconRadius * 1.5 * 3 -
//           MyConstants.defaultPadding * 2;
//     }
//     // _right = 0.0;
//     // _width = 336.72;
//
//     // _right = -36;
//     // _width = 392.72;
//     return Container(
//       padding: EdgeInsets.only(
//         top: MyConstants.defaultPadding,
//         left: MyConstants.defaultPadding,
//         right: MyConstants.defaultPadding,
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Stack(
//               alignment: Alignment.centerLeft,
//               children: [
//                 RowEditSection(
//                   curve: curve,
//                   right: _right,
//                   duration: _duration,
//                   index: fieldIndexInAccount,
//                   // buildItem: buildItem,
//                 ),
//                 AnimatedContainer(
//                   margin: EdgeInsets.only(
//                     top: 5.0,
//                   ),
//                   // without that 'margin' labels in TextFormField are cut, idk why
//                   curve: curve,
//                   width: _width,
//                   duration: _duration,
//                   child: fieldWidget,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//     // Do not allow swipe to dismiss IF edit button is not pressed.
//     // log(fieldIndexInAccount.toString(), name: "INDEX PO");
//     // return AbsorbPointer(
//     //   absorbing: !accountData.isEditButtonPressed,
//     //   child: Dismissible(
//     //     key: accountData.allFields[fieldIndexInAccount].uniqueKey,
//     //     onDismissed: (direction) {
//     //       removeField(fieldIndexInAccount);
//     //     },
//     //     child: editableFieldRow,
//     //   ),
//     // );
//   }
// }
