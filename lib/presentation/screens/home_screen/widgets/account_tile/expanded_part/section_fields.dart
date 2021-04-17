import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/data/models/field_data_entity.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/accounts_cubit.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account_cubit.dart';
import 'package:my_simple_password_storage_clean/presentation/widgets_templates/dialog_template.dart';
import 'package:my_simple_password_storage_clean/presentation/widgets_templates/field_widget.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/AppConstants.dart' as MyConstants;
import 'account_data_expanded_part.dart';
import 'field_edit_section.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionFields extends StatefulWidget {
  SectionFields({
    Key? key,
  }) : super(key: key);

  @override
  SectionFieldsState createState() => SectionFieldsState();
}

class SectionFieldsState extends State<SectionFields> {
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
        for (var i = 0; i < _accountDataEntity.fields.length; i++)
          _accountDataEntity.fields[i].position = i;
        // DataProvider.updateAccount(_accountDataEntity);
        BlocProvider.of<AccountsCubit>(context)
            .accountsRepository
            .updateAccount(_accountDataEntity);
      },
    );
  }

  Widget createProperWidget({required FieldDataEntity fieldDataEntity}) {
    return FieldWidget(
      label: fieldDataEntity.name,
      value: fieldDataEntity.value,
      onChangedCallback: ({required newText}) {
        _isFieldChanged.isFieldChanged = true;
        fieldDataEntity.value = newText;
        _changedFields[fieldDataEntity.uuid!] = fieldDataEntity;

        /// Saving after each letter change.
        // var index = _accountDataEntity.fields
        //     .indexWhere((element) => element.uuid == fieldDataEntity.uuid);
        // _accountDataEntity.fields[index].value = newText;

        // BlocProvider.of<SingleAccountCubit>(context)
        //     .updateAccount(accountDataEntity: _accountDataEntity);
      },
      readOnly: !_accountDataEntity.isEditButtonPressed,
      hiddenValue:
          fieldDataEntity.isHidden && !_accountDataEntity.isShowButtonPressed,
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
    // log('${fieldsDataEntity.length}');

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
          // DataProvider.deleteField(fieldDataEntity);
          BlocProvider.of<SingleAccountCubit>(context)
              .deleteField(fieldDataEntity: fieldDataEntity);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(AppLocalizations.of(context)!
                    .fieldRemovedSnackbar(fieldDataEntity.name))),
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
                    AppLocalizations.of(context)!
                        .removeFieldConfirmationMessage(fieldDataEntity.name),
                  ),
                ),
                title:
                    AppLocalizations.of(context)!.removeFieldConfirmationTitle,
                buttons: [
                  MyDialogButton(
                      buttonName: AppLocalizations.of(context)!.cancel,
                      onPressed: () => Navigator.of(context).pop(false)),
                  MyDialogButton(
                    buttonName: AppLocalizations.of(context)!.remove,
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
