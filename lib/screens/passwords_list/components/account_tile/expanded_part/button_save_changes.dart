import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:mysimplepasswordstorage/screens/passwords_list/components/account_tile/expanded_part/account_data_expanded_part.dart';
import 'package:mysimplepasswordstorage/utils/AppConstants.dart' as MyConstants;
import 'package:provider/provider.dart';

class ButtonSaveChanges extends StatelessWidget {
  ButtonSaveChanges({
    Key? key,
  }) : super(key: key);

  late Map<String, FieldDataEntity> _changedFieldsMap;

  @override
  Widget build(BuildContext context) {
    _changedFieldsMap = Provider.of<Map<String, FieldDataEntity>>(context);

    late ButtonStyle _buttonStyle;
    if (Theme.of(context).textButtonTheme.style != null) {
      _buttonStyle = Theme.of(context).textButtonTheme.style!.copyWith(
          backgroundColor:
              TextButton.styleFrom(backgroundColor: Color(0xFFd6e0f0))
                  .backgroundColor);
    }
    return Padding(
      padding: const EdgeInsets.only(top: MyConstants.defaultPadding),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: _buttonStyle,
              child: Row(
                children: [
                  Icon(
                    Icons.save,
                    color: MyConstants.dismissColor,
                  ),
                  VerticalDivider(color: Colors.black),
                  Text("Save changes"),
                ],
              ),
              onPressed: () {
                _changedFieldsMap.forEach((key, value) {
                  DataProvider.updateField(value);
                });
                _changedFieldsMap.clear();
                Provider.of<IsFieldChanged>(context, listen: false)
                    .isFieldChanged = false;
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Changes saved. :)")));
              },
            ),
          ],
        ),
      ),
    );
  }
}
