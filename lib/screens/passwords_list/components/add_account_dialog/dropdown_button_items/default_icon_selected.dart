import 'package:flutter/material.dart';
import '../../../../../utils/AppConstants.dart' as MyConstants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DefaultIconSelectedDropdownMenuItem extends DropdownMenuItem {
  final MapEntry<String, Image> mapElement;
  final BuildContext context;

  DefaultIconSelectedDropdownMenuItem({
    Key? key,
    required this.mapElement,
    required this.context,
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
                    AppLocalizations.of(context)!.selectIcon,
                textAlign: TextAlign.center,
              )),
            ],
          ),
          value: mapElement.key,
        );
}
