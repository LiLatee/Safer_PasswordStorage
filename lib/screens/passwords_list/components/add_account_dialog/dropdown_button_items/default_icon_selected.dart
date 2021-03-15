import 'package:flutter/material.dart';
import '../../../../../utils/constants.dart' as MyConstants;

class DefaultIconSelectedDropdownMenuItem extends DropdownMenuItem {
  final MapEntry<String, Image> mapElement;
  DefaultIconSelectedDropdownMenuItem({
    Key? key,
    required this.mapElement,
  }) : super(
          child: Row(
            children: <Widget>[
              SizedBox(
                width: MyConstants.defaultPadding / 2,
              ),
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
          value: mapElement.key,
        );
}
