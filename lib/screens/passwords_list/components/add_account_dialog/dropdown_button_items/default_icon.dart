import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import '../../../../../utils/AppConstants.dart' as MyConstants;

typedef void SetChosenDefaultIcon({required Image image, required String iconName});

class DefaultIconDropdownMenuItem extends DropdownMenuItem<String> {
  final SetChosenDefaultIcon setChosenDefaultIconCallback;
  final mapElement;
  final AccountDataEntity accountDataEntity;

  DefaultIconDropdownMenuItem({
    Key? key,
    required this.accountDataEntity,
    this.mapElement,
    required this.setChosenDefaultIconCallback,
  }) : super(
          onTap: () {
            setChosenDefaultIconCallback(image: mapElement.value, iconName: mapElement.key);
          },
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
                  SizedBox(
                    width: MyConstants.defaultPadding,
                  ),
                  Expanded(
                    child: Text(
                      mapElement.key,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          value: mapElement.key,
        );
}
