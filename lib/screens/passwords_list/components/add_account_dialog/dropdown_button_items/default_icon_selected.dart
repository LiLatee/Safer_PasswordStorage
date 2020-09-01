import 'package:flutter/material.dart';
import '../../../../../utils/constants.dart' as MyConstants;

class DefaultIconSelectedDropdownMenuItem extends DropdownMenuItem {
  final mapElement;
  DefaultIconSelectedDropdownMenuItem({
    Key key,
    this.mapElement,
  }) : super(
          child: Padding(
            padding: EdgeInsets.only(bottom: MyConstants.defaultPadding),
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: MyConstants.defaultIconRadius,
                    backgroundImage: mapElement.value.image,
                    backgroundColor: Colors.transparent,
                  ),
                  Expanded(
                      child: Text(
                    'Choose icon',
                    textAlign: TextAlign.center,
                  )),
                ],
              ),
            ),
          ),
          value: mapElement.key,
        );
}
