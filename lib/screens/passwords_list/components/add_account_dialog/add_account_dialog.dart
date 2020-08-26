import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';

import '../../../../constants.dart' as Constants;
import '../../../../utils/functions.dart' as MyFunctions;
import '../../../../components/field_widget.dart';
import 'add_new_field_widget.dart';

class AddAccountDialog extends StatefulWidget {
  final Function addAccountFunc;

  AddAccountDialog({
    @required this.addAccountFunc,
  });

  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  List<Widget> fieldsWidgets = [
    FieldWidget(label: "Account name", isPassword: false),
    FieldWidget(label: "Email", isPassword: false),
    FieldWidget(label: "Password", isPassword: true),
  ];

  Column combinedContent(BuildContext context) {
    return Column(
      children: <Widget>[
        chooseIconSection(context),
        Column(children: fieldsWidgets),
        FlatButton.icon(
            color: Theme.of(context).accentColor,
            onPressed: () {
              setState(() {
                fieldsWidgets.add(
                  AddFieldWidget(label: "Set field name"),
                );
              });
            },
            icon: Icon(Icons.add),
            label: Text("Add field")),
        bottomButtonsSection(context)
      ],
    );
  }

  Container bottomButtonsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Constants.defaultPadding / 2),
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
                onPressed: () {},
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
                onPressed: () {},
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

  Padding chooseIconSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Constants.defaultPadding / 2,
          Constants.defaultPadding / 2, Constants.defaultPadding / 2, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: Constants.defaultPadding / 2),
            child: MyFunctions.generateDefaultIcon(
              accountName: "Icon",
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
                "Change icon",
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyDialog(
        content: combinedContent(context),
        title: AutoSizeText(
          "Adding new account",
          style: Theme.of(context).textTheme.headline2,
          maxLines: 2,
          textAlign: TextAlign.center,
        ));
  }
}
