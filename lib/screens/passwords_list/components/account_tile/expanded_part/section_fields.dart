import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:mysimplepasswordstorage/screens/passwords_list/components/account_tile/expanded_part/account_data_expanded_part.dart';
import 'package:provider/provider.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart' as MyConstants;
import 'package:mysimplepasswordstorage/components/field_widget.dart';
import 'field_edit_section.dart';

class SectionFields extends StatefulWidget {
  SectionFields({
    Key? key,
  }) : super(key: key);

  @override
  SectionFieldsState createState() => SectionFieldsState();
}

class SectionFieldsState extends State<SectionFields>
    with TickerProviderStateMixin {
  List<Widget> fieldsWidgets = [];
  late AccountDataEntity _accountDataEntity;
  late Map<String, FieldDataEntity> _changedFields;
  late IsFieldChanged _isFieldChanged;

  @override
  Widget build(BuildContext context) {
    _accountDataEntity = Provider.of<AccountDataEntity>(context);
    _changedFields = Provider.of<Map<String, FieldDataEntity>>(context);
    _isFieldChanged = Provider.of<IsFieldChanged>(context);

    fieldsWidgets = buildFieldsWidgets(
      context: context,
      fieldsDataEntity: _accountDataEntity.fields,
    );

    /// TODO: That has to be changed. There is no a proper way to disable reorder in ReorderableListView,
    /// so it has to be used another reorderable widget to make it possible.
    /// Current solution 'works', but there are is no animation during turning on edit mode,
    /// because we are using two separate AnimatedContainers so it does not animate properly.
    return _accountDataEntity.isEditButtonPressed
        ? ReorderableListView(
            shrinkWrap: true,
            children: fieldsWidgets,
            onReorder: _onReorder,
          )
        : ListView(
            padding: EdgeInsets.all(0.0),
            shrinkWrap: true,
            children: fieldsWidgets,
          );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final FieldDataEntity removedItem =
            _accountDataEntity.fields.removeAt(oldIndex);

        _accountDataEntity.fields.insert(newIndex, removedItem);

        /// Set all new indices.
        for (var i = 0; i <_accountDataEntity.fields.length; i++)
            _accountDataEntity.fields[i].position = i;
        DataProvider.updateAccount(_accountDataEntity);
      },
    );
  }

  Widget createProperWidget({required FieldDataEntity fieldDataEntity}) {
    return FieldWidget(
      label: fieldDataEntity.name,
      value: fieldDataEntity.value,
      onChangedCallback: ({required newText}) {
        _changedFields[fieldDataEntity.uuid!] = fieldDataEntity;
        _isFieldChanged.isFieldChanged = true;
        return fieldDataEntity.value = newText;
      },
      readOnly: !Provider.of<AccountDataEntity>(context).isEditButtonPressed,
      hiddenValue: fieldDataEntity.isHidden &&
          !Provider.of<AccountDataEntity>(context).isShowButtonPressed,
      multiline: fieldDataEntity.isMultiline,
      textInputAction: fieldDataEntity.isMultiline
          ? TextInputAction.newline
          : TextInputAction.done,
      textInputType: fieldDataEntity.isMultiline
          ? TextInputType.multiline
          : TextInputType.text,
    );
  }

  List<Widget> buildFieldsWidgets(
      {required BuildContext context,
      required List<FieldDataEntity> fieldsDataEntity}) {
    return fieldsDataEntity
        .map(
          (e) => Container(
            key: ValueKey(e.uuid),
            child: createFieldRowWidget(
              context: context,
              fieldWidget: createProperWidget(fieldDataEntity: e),
              fieldDataEntity: e,
            ),
          ),
        )
        .toList();
  }

  Widget createFieldRowWidget(
      {required BuildContext context,
      required FieldDataEntity fieldDataEntity,
      required Widget fieldWidget}) {
    Size size = MediaQuery.of(context).size;
    double _width = size.width;
    double _right = -3 * MyConstants.defaultIconRadius * 1.5;
    Curve curve = Curves.easeInOutBack;

    /// Do not show edit actions IF edit button is not pressed.
    if (!_accountDataEntity.isEditButtonPressed) {
      // curve = Curves.easeInBack;
      _right = -1 * MyConstants.defaultIconRadius * 1.5;
      _width = size.width;
    } else if (_accountDataEntity.isEditButtonPressed) {
      // curve = Curves.easeOutBack;
      _right = 0;
      _width = size.width -
          MyConstants.defaultIconRadius * 1.5 * 1 -
          MyConstants.defaultPadding * 2;
    }

    /// Do not allow swipe to dismiss IF edit button is not pressed.
    final Duration _duration = MyConstants.animationsDuration * 2;
    var withoutDismissible = Container(
      padding: const EdgeInsets.only(
        top: MyConstants.defaultPadding,
        left: MyConstants.defaultPadding,
        right: MyConstants.defaultPadding,
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                FieldEditSection(
                  curve: curve,
                  right: _right,
                  duration: _duration,
                  index: fieldDataEntity.position, // TODO
                  // buildItem: buildItem,
                ),
                AnimatedContainer(
                  margin: EdgeInsets.only(
                    top: 5.0,
                  ),
                  // without that 'margin' labels in TextFormField are cut, idk why
                  curve: curve,
                  width: _width,
                  duration: _duration,
                  child: fieldWidget,
                ),
              ],
            ),
          )
        ],
      ),
    );

    /// TODO: Same situation like with ReorderableListView, it has to be possibility to turn off dismiss
    var resultWidget;
    if (!_accountDataEntity.isEditButtonPressed)
      resultWidget = withoutDismissible;
    else
      resultWidget = Dismissible(
        direction: DismissDirection.horizontal,
        key: ValueKey(fieldDataEntity.uuid),
        onDismissed: (direction) {
          DataProvider.deleteField(fieldDataEntity);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Field '${fieldDataEntity.name}' removed.")),
          );
        },
        background: Container(color: MyConstants.dismissColor),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) {
              return MyDialog(
                content: Padding(
                  padding:
                      const EdgeInsets.only(top: MyConstants.defaultPadding),
                  child: Text(
                    "Do you want to remove '${fieldDataEntity.name}' field?",
                  ),
                ),
                title: "Confirmation",
                buttons: [
                  MyDialogButton(
                      buttonName: "Cancel",
                      onPressed: () => Navigator.of(context).pop(false)),
                  MyDialogButton(
                    buttonName: "Remove",
                    onPressed: () => Navigator.of(context).pop(true),
                  )
                ],
              );
            },
          );
        },
        child: withoutDismissible,
      );

    return resultWidget;
  }
}
