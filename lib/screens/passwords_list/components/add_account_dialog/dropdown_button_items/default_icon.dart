import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import '../../../../../models/account_data.dart';
import '../../../../../utils/constants.dart' as MyConstants;

typedef void SetChosenDefaultIcon({AssetImage image});

class DefaultIconDropdownMenuItem extends DropdownMenuItem {
  final SetChosenDefaultIcon setChosenDefaultIconCallback;
  final mapElement;
  final AccountDataEntity accountDataEntity;

  DefaultIconDropdownMenuItem({
    Key key,
    @required this.accountDataEntity,
    this.mapElement,
    this.setChosenDefaultIconCallback,
  }) : super(
          onTap: () {
            setChosenDefaultIconCallback(image: mapElement.value.image);
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
