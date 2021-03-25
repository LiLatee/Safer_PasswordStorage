import 'package:flutter/material.dart';
import '../../../../../utils/AppConstants.dart' as MyConstants;

typedef void ShowColorPicker({required bool isShowNeeded});

class ChooseColorDropdownMenuItem extends DropdownMenuItem<String> {
  final ShowColorPicker showColorPickerCallback;
  final Widget chooseColorIconWidget;

  ChooseColorDropdownMenuItem({
    Key? key,
    required this.chooseColorIconWidget,
    required this.showColorPickerCallback,
  }) : super(
            onTap: () {
              showColorPickerCallback(isShowNeeded: true);
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
                        chooseColorIconWidget,
                        SizedBox(
                          width: MyConstants.defaultPadding,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Choose color',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MyConstants.defaultPadding),
                  child: Divider(
                    color: Colors.black,
                    height: 1,
                  ),
                ),
              ],
            ));
}
