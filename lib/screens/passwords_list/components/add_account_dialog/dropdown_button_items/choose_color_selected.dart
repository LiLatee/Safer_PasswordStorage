import 'package:flutter/material.dart';
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
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MyConstants.defaultPadding / 2,
                ),
                icon,
                Expanded(
                  child: Text(
                    'Select icon',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ));
}
