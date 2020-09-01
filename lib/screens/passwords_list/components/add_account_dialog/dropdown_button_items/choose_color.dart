import 'package:flutter/material.dart';
import '../../../../../utils/constants.dart' as MyConstants;

typedef void ShowColorPicker({bool isShowNeeded});

class ChooseColorDropdownMenuItem extends DropdownMenuItem {
  final ShowColorPicker showColorPickerCallback;
  final Widget chooseColorIcon;

  ChooseColorDropdownMenuItem({
    Key key,
    @required this.chooseColorIcon,
    this.showColorPickerCallback,
  }) : super(
            onTap: () {
              showColorPickerCallback(isShowNeeded: true);
              // showDialog(
              //     barrierDismissible: false,
              //     context: context,
              //     child: MyDialog(
              //       title: 'Pick a color',
              //       content: Container(
              //         margin: EdgeInsets.all(MyConstants.defaultPadding),
              //         width: MediaQuery.of(context).size.width * 0.8,
              //         child: BlockPicker(
              //           availableColors: MyConstants.iconDefaultColors,
              //           pickerColor: currentColor,
              //           onColorChanged: (value) {
              //             changeIconColor(value);
              //             Navigator.of(context).pop();
              //           },
              //           // availableColors: , TODO wybrać kolory
              //         ),
              //       ),
              //     ));
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
                        chooseColorIcon,
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
