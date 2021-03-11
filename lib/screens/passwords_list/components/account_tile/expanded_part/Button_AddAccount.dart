import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/components/field_widget.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;

import 'AccountButtonTemplate.dart';

class ButtonAddAccount extends StatelessWidget {
  final AccountDataEntity _accountDataEntity;
  final DataProvider _dataProvider;

  ButtonAddAccount({
    Key key,
    @required DataProvider dataProvider,
    @required AccountDataEntity accountDataEntity,
  })  : _accountDataEntity = accountDataEntity,
        _dataProvider = dataProvider,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AccountButtonTemplate(
        onPressed: () async {
          if (!_accountDataEntity.isEditButtonPressed)
            _dataProvider.toggleEditButton(
                accountDataEntity: _accountDataEntity);

          var result = await showDialog(
            context: context,
            builder: (context) {
              bool isHidden = false;
              bool isMultiline = false;
              var name;
              var value;
              return StatefulBuilder(
                builder: (context, setState) => MyDialog(
                  title: "Add new field",
                  content: Padding(
                    padding: const EdgeInsets.only(
                        top: MyConstants.defaultPadding,
                        left: MyConstants.defaultPadding,
                        right: MyConstants.defaultPadding),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: MyConstants.defaultPadding),
                          child: AdditionalFieldWidget(
                            label: "Name",
                            readOnly: false,
                            value: "",
                            onChangedCallback: ({newText}) => name = newText,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        AdditionalFieldWidget(
                          label: "Content",
                          readOnly: false,
                          value: "",
                          onChangedCallback: ({newText}) => value = newText,
                          textInputAction: isMultiline
                              ? TextInputAction.newline
                              : TextInputAction.done,
                          textInputType: isMultiline
                              ? TextInputType.multiline
                              : TextInputType.text,
                          hiddenValue: isHidden,
                          multiline: isMultiline,
                        ),
                        Row(
                          children: [
                            Text("Hide the value of field?"),
                            Switch(
                              value: isHidden,
                              onChanged: (value) {
                                setState(() {
                                  if (isMultiline) isMultiline = false;
                                  isHidden = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Multiline?"),
                            Switch(
                              value: isMultiline,
                              onChanged: (value) {
                                setState(() {
                                  if (isHidden) isHidden = false;
                                  isMultiline = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  buttons: [
                    MyDialogButton(
                        buttonName: "Cancel",
                        onPressed: () => Navigator.of(context).pop(null)),
                    MyDialogButton(
                      buttonName: "Add",
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Added field \"${name}\"")));
                        Navigator.of(context).pop({
                          "name": name,
                          "value": value,
                          "isHidden": isHidden,
                          "isMultiline": isMultiline,
                        });
                      },
                    )
                  ],
                ),
              );
            },
          );

          if (result != null)
            _dataProvider.addField(
              FieldDataEntity(
                accountId: _accountDataEntity.id,
                name: result['name'],
                value: result['value'],
                isHidden: result['isHidden'],
                isMultiline: result['isMultiline'],
              ),
            );

          /// If using AnimatedList instead of ReorderableListView
          // account.listKey.currentState.insertItem(account.getNumberOfFields - 1,
          //     duration: MyConstants.animationsDuration);
        },
        icon: Icon(Icons.add),
        label: 'Add field');
  }
}
