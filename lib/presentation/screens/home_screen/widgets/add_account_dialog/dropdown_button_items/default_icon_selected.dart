import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/constants/AppConstants.dart' as AppConstants;

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
                width: AppConstants.defaultPadding / 2,
              ),
              CircleAvatar(
                radius: AppConstants.defaultIconRadius,
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
