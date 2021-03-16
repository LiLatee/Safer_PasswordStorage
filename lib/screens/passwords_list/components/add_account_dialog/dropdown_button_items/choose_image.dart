import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:provider/provider.dart';
import '../../../../../utils/constants.dart' as MyConstants;

typedef void SetIconImage({required PickedFile pickedFile});

class ChooseImageDropdownMenuItem extends DropdownMenuItem<String> {
  final SetIconImage setIconImageCallback;
  final BuildContext context;

  ChooseImageDropdownMenuItem({
    Key? key,
    required this.setIconImageCallback,
    required this.context
  }) : super(
            onTap: () async {

              ImagePicker().getImage(source: ImageSource.gallery).then((PickedFile? value)
              async {
                if (value != null)
                  {
                    setIconImageCallback(
                      pickedFile: value ,
                    );
                  }
              });
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
