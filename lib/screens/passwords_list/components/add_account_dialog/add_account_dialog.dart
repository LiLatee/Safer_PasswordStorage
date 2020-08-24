import 'package:flutter/material.dart';

import '../../../../BLoCs/all_accounts_bloc.dart';
import '../../../../constants.dart' as Constants;
import '../../../../utils/functions.dart' as MyFunctions;
import '../../../../models/account_data.dart';
import 'field_widget.dart';
import 'fields_section.dart';

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
    FieldWidget(label: "Email", isPassword: false),
    FieldWidget(label: "Password", isPassword: true),
    FieldWidget(label: "Nick", isPassword: false),
  ];

  dialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 25.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(top: 25),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Constants.defaultPadding / 2,
                        Constants.defaultPadding / 2,
                        Constants.defaultPadding / 2,
                        0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              right: Constants.defaultPadding / 2),
                          child: MyFunctions.generateDefaultIcon(
                            accountName: "Icon",
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          color: Theme.of(context).accentColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            // side: BorderSide(
                            //   color: Theme.of(context).accentColor,
                            //   width: 2.0,
                            // ),
                          ),
                          // color: Theme.of(context).buttonColor,
                          child: Container(
                            child: Text(
                              "Change icon",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: fieldsWidgets,
                  ),
                  Container(
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
                          VerticalDivider(
                              color: Theme.of(context).primaryColor),
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
                  )
                ],
              ),
            ),
            buildDialogHeader(context)
          ],
        ),
      ],
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
          child: Text(
            "Adding new account",
            style: Theme.of(context).textTheme.headline2,
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
      child: dialogContent(context),
    );
  }
}
