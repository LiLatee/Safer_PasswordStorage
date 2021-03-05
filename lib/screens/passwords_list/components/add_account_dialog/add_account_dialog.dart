import 'package:flutter/material.dart';

import 'package:mysimplepasswordstorage/components/account_name_field_widget.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;
import 'package:mysimplepasswordstorage/utils/functions.dart' as MyFunctions;
import 'package:provider/provider.dart';
import 'choose_icon_widget.dart';

class AddAccountDialog extends StatefulWidget {
  final BuildContext superContext;

  AddAccountDialog({this.superContext});

  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  AccountDataEntity accountDataEntity = AccountDataEntity(accountName: 'Account name');
  Color currentColor = MyConstants.iconDefaultColors[0];
  final accountNameFormKey = GlobalKey<FormState>();

  bool isChosenColorIcon = true;

  void setAccountName({String accountName}) {
    setState(() {
      accountDataEntity.accountName = accountName;
      // if (isChosenColorIcon) {
      //   accountDataEntity.icon = MyFunctions.generateRandomColorIcon(
      //     name: accountData.accountName,
      //     color: currentColor,
      //   );
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cancelButton = MyDialogButton(
        buttonName: "Cancel",
        onPressed: () {
          Navigator.of(context).pop();
        });

    var addButton = MyDialogButton(
        buttonName: "Add",
        onPressed: () {
          if (accountNameFormKey.currentState.validate()) {
            Provider.of<DataProvider>(widget.superContext, listen: false).addAccount(accountDataEntity);
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Dodano konto "${accountDataEntity.accountName}"')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Coś nie tak przy dodawaniu konta ;(')));
          }
        });

    return MyDialog(
      buttons: [cancelButton, addButton],
      content: Column(
        children: <Widget>[
          AccountNameFieldWidget(
            superContext: widget.superContext,
            onChangedCallback: setAccountName,
            accountNameFormKey: accountNameFormKey,
          ),
          // ChooseIconWidget(
          //   accountDataEntity: accountDataEntity,
          //   setAccountDataCallback: ({accountDataEntity}) =>
          //       this.accountDataEntity = accountDataEntity,
          //   setIsChosenColorIconCallback: ({isChosenColorIcon}) =>
          //       this.isChosenColorIcon = isChosenColorIcon,
          //   currentColor: currentColor,
          //   setCurrentColorCallback: ({color}) => currentColor = color,
          // ),
          // bottomButtonsSection(context)
        ],
      ),
      title: "Adding new account",
    );
  }

// Widget bottomButtonsSection(BuildContext context) {
//   return Container(
//     margin: EdgeInsets.only(top: MyConstants.defaultPadding),
//     decoration: BoxDecoration(
//       color: Theme.of(context).accentColor,
//       borderRadius: BorderRadius.only(
//         bottomLeft: Radius.circular(MyConstants.defaultCircularBorderRadius),
//         bottomRight: Radius.circular(MyConstants.defaultCircularBorderRadius),
//       ),
//     ),
//     child: IntrinsicHeight(
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: FlatButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Container(
//                 child: Text(
//                   "Cancel",
//                 ),
//               ),
//             ),
//           ),
//           VerticalDivider(color: Theme.of(context).primaryColor),
//           Expanded(
//             child: FlatButton(
//               onPressed: () {
//                 if (accountNameFormKey.currentState.validate()) {
//                   // if (chooseImageIcon == null) {
//                   //   accountData.icon = chooseColorIcon;
//                   // }
//                   widget.addAccountCallback(accountData: accountData);
//                   Navigator.of(context).pop();
//                 } else {
//                   // Scaffold.of(context)
//                   //     .showSnackBar(SnackBar(content: Text('zle')));
//                 }
//               },
//               child: Container(
//                 child: Text("Add"),
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );
// }
}
