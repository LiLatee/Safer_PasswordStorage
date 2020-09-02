import 'package:flutter/material.dart';
import '../../../../../utils/constants.dart' as MyConstants;

class ChooseImageSelectedDropdownMenuItem extends DropdownMenuItem {
  final Widget chooseImageIcon;
  ChooseImageSelectedDropdownMenuItem({
    Key key,
    @required this.chooseImageIcon,
  }) : super(
            value: 'Choose image',
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: MyConstants.defaultPadding / 2,
                ),
                chooseImageIcon ??
                    Icon(
                      Icons.image,
                      size: MyConstants.defaultIconRadius * 2,
                    ),
                Expanded(
                    child: Text(
                  'Choose icon',
                  textAlign: TextAlign.center,
                )),
              ],
            ));
}
