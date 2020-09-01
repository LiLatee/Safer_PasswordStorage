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
              File file = await FilePicker.getFile(type: FileType.image);
              setIconImageCallback(
                  image: Image.asset(file.path,
                      width: MyConstants.defaultIconRadius * 2,
                      height: MyConstants.defaultIconRadius * 2));
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
