import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/constants/AppConstants.dart';

typedef void SetIconImage({required PickedFile pickedFile});

class ChooseImageDropdownMenuItem extends DropdownMenuItem<String> {
  final SetIconImage setIconImageCallback;
  final BuildContext context;

  ChooseImageDropdownMenuItem({
    Key? key,
    required this.setIconImageCallback,
    required this.context,
  }) : super(
            onTap: () async {
              ImagePicker()
                  .getImage(source: ImageSource.gallery)
                  .then((PickedFile? value) async {
                if (value != null) {
                  setIconImageCallback(
                    pickedFile: value,
                  );
                }
              });
            },
            value: 'Choose image',
            child: Container(
              margin: EdgeInsets.only(bottom: AppConstants.defaultPadding),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.image,
                      size: AppConstants.defaultIconRadius * 2,
                    ),
                    SizedBox(
                      width: AppConstants.defaultPadding,
                    ),
                    Text(AppLocalizations.of(context)!.chooseImage),
                  ],
                ),
              ),
            ));
}
