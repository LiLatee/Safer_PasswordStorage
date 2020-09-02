import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/constants.dart' as MyConstants;

typedef void SetIconImage({Image image});

class ChooseImageDropdownMenuItem extends DropdownMenuItem {
  final SetIconImage setIconImageCallback;
  ChooseImageDropdownMenuItem({
    Key key,
    this.setIconImageCallback,
  }) : super(
            onTap: () async {
              FilePicker.getFile(type: FileType.image).then((value) {
                setIconImageCallback(
                    image: Image.file(value,
                        width: MyConstants.defaultIconRadius * 2,
                        height: MyConstants.defaultIconRadius * 2));
              }).catchError(print); // TODO LOG?
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
