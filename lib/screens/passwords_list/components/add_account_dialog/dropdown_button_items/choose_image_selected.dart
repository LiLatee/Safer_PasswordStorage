import 'package:flutter/material.dart';
import '../../../../../utils/constants.dart' as MyConstants;

class ChooseImageSelectedDropdownMenuItem extends DropdownMenuItem {
  final Widget chooseImageIcon;
  ChooseImageSelectedDropdownMenuItem({
    Key key,
    @required this.chooseImageIcon,
  }) : super(
            value: 'Choose image',
            child: Padding(
              padding: EdgeInsets.only(bottom: MyConstants.defaultPadding),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
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
                ),
              ),
            ));
}
