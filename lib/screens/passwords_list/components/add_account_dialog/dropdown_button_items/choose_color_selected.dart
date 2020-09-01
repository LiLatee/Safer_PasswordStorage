import 'package:flutter/material.dart';
import '../../../../../models/account_data.dart';
import '../../../../../utils/constants.dart' as MyConstants;

typedef void ShowColorPicker({bool isShowNeeded});

class ChooseColorSelectedDropdownMenuItem extends DropdownMenuItem {
  final ShowColorPicker callback;
  final Widget icon;
  ChooseColorSelectedDropdownMenuItem({
    Key key,
    this.callback,
    @required this.icon,
  }) : super(
            onTap: () {
              callback(isShowNeeded: true);
            },
            value: 'Choose color',
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: MyConstants.defaultPadding),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        icon,
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Select icon',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
}
