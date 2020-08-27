import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/account_name_field_widget.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';

import '../../../../utils/constants.dart' as Constants;
import '../../../../utils/functions.dart' as MyFunctions;
import '../../../../components/field_widget.dart';
import 'add_new_field_widget.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
  setNewAccountNamecallback({String accountName}) {
    setState(() {
      this.accountName = accountName;
    });
  }

  // List<Widget> fieldsWidgets = [
  //   FieldWidget(label: "Account name", isPassword: false,),
  // FieldWidget(label: "Email", isPassword: false),
  // FieldWidget(label: "Password", isPassword: true),
  // ];

  String accountName = 'Account name';
  Widget icon;
  final accountNameFormKey = GlobalKey<FormState>();

  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);

  void changeIconColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    icon = MyFunctions.generateRandomColorIcon(
      name: accountName,
      color: pickerColor,
    );

    return MyDialog(
      content: combinedContent(context),
      title: "Adding new account",
    );
  }

  Column combinedContent(BuildContext context) {
    return Column(
      children: <Widget>[
        AccountNameFieldWidget(
          currentAccounts: widget.currentAccounts,
          onChangedCallback: setNewAccountNamecallback,
          accountNameFormKey: accountNameFormKey,
        ),
        chooseIconSection(context),
        bottomButtonsSection(context)
      ],
    );
  }

  Widget chooseIconSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Constants.defaultPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          icon,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      child: AlertDialog(
                        title: Text('Pick a color'),
                        content: BlockPicker(
                          pickerColor: currentColor,
                          onColorChanged: changeIconColor,
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: const Text(
                              'Got it',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              setState(() => currentColor = pickerColor);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ));
                },
                color: Theme.of(context).accentColor,
                // shape: RoundedRectangleBorder(
                //     // borderRadius: BorderRadius.circular(20.0),
                //     // side: BorderSide(
                //     //   color: Theme.of(context).accentColor,
                //     //   width: 2.0,
                //     // ),
                //     ),
                // color: Theme.of(context).buttonColor,
                child: Container(
                  child: Text(
                    "Choose color",
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {},
                color: Theme.of(context).accentColor,
                // shape: RoundedRectangleBorder(
                //     // borderRadius: BorderRadius.circular(20.0),
                //     // side: BorderSide(
                //     //   color: Theme.of(context).accentColor,
                //     //   width: 2.0,
                //     // ),
                //     ),
                // color: Theme.of(context).buttonColor,
                child: Container(
                  child: Text(
                    "Choose image",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bottomButtonsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Constants.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: Text(
                    "Cancel",
                  ),
                ),
              ),
            ),
            VerticalDivider(color: Theme.of(context).primaryColor),
            Expanded(
              child: FlatButton(
                onPressed: () {
                  if (accountNameFormKey.currentState.validate()) {
                    log("DODANE", name: "LOL");
                    widget.addAccountCallback(
                        accountData:
                            AccountData(accountName: accountName, icon: icon));
                    Navigator.of(context).pop();
                  } else {
                    log("NIE DODANE", name: "LOL");
                    // Scaffold.of(context)
                    //     .showSnackBar(SnackBar(content: Text('zle')));
                  }
                },
                child: Container(
                  child: Text("Add"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
