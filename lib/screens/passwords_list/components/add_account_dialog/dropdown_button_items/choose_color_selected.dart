import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;
import 'package:mysimplepasswordstorage/utils/functions.dart' as MyFunctions;

typedef void ShowColorPicker({required bool isShowNeeded});

class ChooseColorSelectedDropdownMenuItem extends DropdownMenuItem {
  final ShowColorPicker? showColorPickerCallback;
  final Widget icon;

  ChooseColorSelectedDropdownMenuItem({
    Key? key,
    this.showColorPickerCallback,
    required this.icon,
  }) : super(
            onTap: () {
              if (showColorPickerCallback != null)
                showColorPickerCallback(isShowNeeded: true);
            },
            value: 'Choose color',
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MyConstants.defaultPadding / 2,
                ),
                icon,
                // MyFunctions.generateRandomColorIconAsWidget(
                //   name: 'A',
                //   color: MyConstants.iconDefaultColors[5],
                // ),
                Expanded(
                  child: Text(
                    'Select icon',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ));
}
