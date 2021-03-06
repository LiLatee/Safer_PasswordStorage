import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/constants.dart' as MyConstants;

typedef void SetIconImage({Image image});

class ChooseImageDropdownMenuItem extends DropdownMenuItem {
  final SetIconImage setIconImageCallback;
  final BuildContext context;

  ChooseImageDropdownMenuItem({
    Key key,
    this.setIconImageCallback,
    this.context
  }) : super(
            onTap: () async {
              ImagePicker().getImage(source: ImageSource.gallery).then((PickedFile value)
              async {
                Provider.of<AccountDataEntity>(context, listen: false).iconImage = await value.readAsBytes();
                setIconImageCallback(
                  image: Image.file(
                    File(value.path),
                    width: MyConstants.defaultIconRadius * 2,
                    height: MyConstants.defaultIconRadius * 2,
                  ),
                );
              });

              // FilePicker.getFile(type: FileType.image).then((value) {
              //   setIconImageCallback(
              //     image: Image.file(
              //       value,
              //       width: MyConstants.defaultIconRadius * 2,
              //       height: MyConstants.defaultIconRadius * 2,
              //     ),
              //   );
              // }).catchError(print); // TODO LOG?
            },
            value: 'Choose image',
            child: Container(
              margin: EdgeInsets.only(bottom: MyConstants.defaultPadding),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.image,
                      size: MyConstants.defaultIconRadius * 2,
                    ),
                    SizedBox(
                      width: MyConstants.defaultPadding,
                    ),
                    Text('Choose image'),
                  ],
                ),
              ),
            ));
}
