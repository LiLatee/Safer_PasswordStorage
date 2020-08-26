// import 'dart:developer';

// import 'package:flutter/material.dart';

// import '../../../../constants.dart' as constants;
// import '../../../../models/account_data.dart';
// import '../../../../utils/functions.dart' as functions;
// import '../../../../utils/functions.dart';
// import 'buttons_section.dart';
// import 'fields_section.dart';

// class AccountTile2 extends StatefulWidget {
//   final AccountData accountData;
//   final int index;
//   final int selectedTileIndex;
//   final Function(int) callback;

//   AccountTile2({
//     Key key,
//     @required this.accountData,
//     @required this.selectedTileIndex,
//     @required this.index,
//     @required this.callback,
//   }) : super(key: key);

//   @override
//   _AccountTile2State createState() => _AccountTile2State();
// }

// class _AccountTile2State extends State<AccountTile2> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return ExpansionPanel(
//         headerBuilder: (BuildContext context, bool isExpanded) {
//           return Text("111");
//         },
//         body: buildExpandedPart());
//   }

//   Widget buildExpandedPart() {
//     return Column(
//       children: <Widget>[
//         FieldsSection(accountData: widget.accountData),
//         ButtonsSection(),
//       ],
//     );
//   }

//   Widget buildCircleAvatar({String iconName, double radius = 25.0}) {
//     var icon;
//     if (constants.availableIconsNames.contains(iconName)) {
//       icon = AssetImage(
//           'images/${widget.accountData.accountName.toLowerCase()}.png');

//       return CircleAvatar(
//         radius: radius,
//         backgroundImage: icon,
//         backgroundColor: Colors.transparent,
//       );
//     }
//     icon = functions.generateDefaultIcon(
//         accountName: widget.accountData.accountName, radius: radius);

//     return icon;
//   }
// }
