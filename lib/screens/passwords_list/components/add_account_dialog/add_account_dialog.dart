import 'package:flutter/material.dart';

import 'package:mysimplepasswordstorage/components/account_name_field_widget.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;
import 'package:mysimplepasswordstorage/utils/functions.dart' as MyFunctions;
import 'choose_icon_widget.dart';

class AddAccountDialog extends StatefulWidget {
  final Function addAccountCallback;
  final List<AccountData> currentAccounts;

  AddAccountDialog({
    @required this.addAccountCallback,
    @required this.currentAccounts,
  });

  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  AccountData accountData = AccountData(accountName: 'Account name');
  final accountNameFormKey = GlobalKey<FormState>();
  Color currentColor = MyConstants.iconDefaultColors[0];
  bool isChosenColorIcon = true;

  void setAccountName({String accountName}) {
    setState(() {
      accountData.accountName = accountName;
      if (isChosenColorIcon) {
        accountData.icon = MyFunctions.generateRandomColorIcon(
          name: accountData.accountName,
          color: currentColor,
        );
      }
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
            widget.addAccountCallback(accountDataEntity: accountData);
            Navigator.of(context).pop();
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(content: Text('zle')));
          }
        });

    return MyDialog(
      buttons: [cancelButton, addButton],
      content: Column(
        children: <Widget>[
          AccountNameFieldWidget(
            currentAccounts: widget.currentAccounts,
            onChangedCallback: setAccountName,
            accountNameFormKey: accountNameFormKey,
          ),
          ChooseIconWidget(
            accountData: accountData,
            setAccountDataCallback: ({accountData}) =>
                this.accountData = accountData,
            setIsChosenColorIconCallback: ({isChosenColorIcon}) =>
                this.isChosenColorIcon = isChosenColorIcon,
            currentColor: currentColor,
            setCurrentColorCallback: ({color}) => currentColor = color,
          ),
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
