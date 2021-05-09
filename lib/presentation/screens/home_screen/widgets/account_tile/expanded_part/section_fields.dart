import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../logic/cubit/all_accounts/accounts_cubit.dart';
import '../../../../../../logic/cubit/single_account/delete_field_cubit.dart';
import '../../../../../../logic/cubit/single_account/edit_single_account_cubit.dart';
import '../../../../../../data/models/account_data_entity.dart';
import '../../../../../../data/models/field_data_entity.dart';
import '../../../../../widgets_templates/dialog_template.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/constants/AppConstants.dart';
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
  Map<String, TextEditingController> _textEditingControllerMap =
      <String, TextEditingController>{};

  @override
  Widget build(BuildContext context) {
    _accountDataEntity = Provider.of<AccountDataEntity>(context);
    for (var field in _accountDataEntity.fields)
      if (!_textEditingControllerMap.containsKey(field.uuid))
        _textEditingControllerMap[field.uuid!] = TextEditingController();

    fieldsWidgets = buildFieldsWidgets(
      context: context,
      fieldsDataEntity: _accountDataEntity.fields,
    );

    // log("AccountData w section_fields");
    // log(_accountDataEntity.toString());

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
        BlocProvider.of<AccountsCubit>(context)
            .accountsRepository
            .updateAccount(accountData: _accountDataEntity);
      },
    );
  }

  Widget createProperWidget({required FieldDataEntity fieldDataEntity}) {
    _textEditingControllerMap[fieldDataEntity.uuid]!.text =
        fieldDataEntity.value;
    _textEditingControllerMap[fieldDataEntity.uuid]!.selection =
        TextSelection.fromPosition(TextPosition(
            offset:
                _textEditingControllerMap[fieldDataEntity.uuid]!.text.length));
    return buildFieldWidget(fieldDataEntity);
  }

  Form buildFieldWidget(FieldDataEntity fieldDataEntity) {
    return Form(
      child: TextFormField(
        // key: ObjectKey(fieldDataEntity.name), // TODO potrzebne?
        controller: _textEditingControllerMap[fieldDataEntity.uuid]!,
        maxLines: fieldDataEntity.isMultiline == true ? null : 1,
        readOnly: !_accountDataEntity.isEditButtonPressed,
        obscureText:
            fieldDataEntity.isHidden && !_accountDataEntity.isShowButtonPressed,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: fieldDataEntity.name,
        ),
        textInputAction: fieldDataEntity.isMultiline
            ? TextInputAction.newline
            : TextInputAction.done,
        keyboardType: fieldDataEntity.isMultiline
            ? TextInputType.multiline
            : TextInputType.text,
        onChanged: (value) {
          // fieldDataEntity.value = newText;
          if (value != fieldDataEntity.value) {
            BlocProvider.of<EditSingleAccountCubit>(context).changeField(
                fieldDataEntity: fieldDataEntity.copyWith(value: value));
          }
        },
      ),
    );
  }

// Widget buildFieldWidget() {
//   return Form(
//     child: TextFormField(
//       maxLines: multiline == true ? null : 1,
//       obscureText: hiddenValue,
//     ),);
// }

// ////////////
// class FieldWidget extends StatelessWidget {
//   const FieldWidget(
//       {Key? key,
//       required this.label,
//       this.value = "",
//       this.isPassword = false,
//       this.readOnly = true,
//       this.maxLines = 1,
//       this.textInputType = TextInputType.text,
//       this.onChangedCallback,
//       this.onEditingComplete,
//       this.textInputAction = TextInputAction.done,
//       this.onFieldSubmitted,
//       this.multiline = false,
//       this.hiddenValue = false,
//       this.controller})
//       : super(key: key);

//   final bool readOnly;
//   final String label;
//   final String value;
//   final bool isPassword;
//   final onChangeText? onChangedCallback;
//   final int? maxLines;
//   final TextInputType textInputType;
//   final Function? onEditingComplete;
//   final onChangeText? onFieldSubmitted;
//   final TextInputAction textInputAction;
//   final bool multiline;
//   final bool hiddenValue;
//   final TextEditingController? controller;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       key: ObjectKey(label),
//       controller: controller,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: label,
//       ),
//       readOnly: readOnly,
//       keyboardType: textInputType,
//       minLines: 1,
//       maxLines: multiline == true ? null : 1,
//       obscureText: hiddenValue,
//       enableInteractiveSelection: true,
//       onChanged: (value) {
//         if (onChangedCallback != null) onChangedCallback!(newText: value);
//       },
//       onEditingComplete: () {
//         if (onEditingComplete != null) onEditingComplete!();
//       },
//       onFieldSubmitted: (value) {
//         if (onFieldSubmitted != null) {
//           onFieldSubmitted!(newText: value);
//           FocusScope.of(context).unfocus();
//         }
//       },
//       textInputAction: textInputAction,
//     );
//   }
// }
//////////

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
    double _right = -3 * AppConstants.defaultIconRadius * 1.5;
    Curve curve = Curves.easeInOutBack;

    /// Do not show edit actions IF edit button is not pressed.
    if (!_accountDataEntity.isEditButtonPressed) {
      // curve = Curves.easeInBack;
      _right = -1 * AppConstants.defaultIconRadius * 1.5;
      _width = size.width;
    } else if (_accountDataEntity.isEditButtonPressed) {
      // curve = Curves.easeOutBack;
      _right = 0;
      _width = size.width -
          AppConstants.defaultIconRadius * 1.5 * 1 -
          AppConstants.defaultPadding * 2;
    }

    /// Do not allow swipe to dismiss IF edit button is not pressed.
    final Duration _duration = AppConstants.animationsDuration * 2;
    var withoutDismissible = Container(
      padding: const EdgeInsets.only(
        top: AppConstants.defaultPadding,
        left: AppConstants.defaultPadding,
        right: AppConstants.defaultPadding,
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
          BlocProvider.of<DeleteFieldCubit>(context)
              .deleteField(fieldDataEntity: fieldDataEntity);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!
                    .fieldRemovedSnackbar(fieldDataEntity.name),
              ),
            ),
          );
        },
        background: Container(color: AppConstants.dismissColor),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) {
              return MyDialog(
                content: Padding(
                  padding:
                      const EdgeInsets.only(top: AppConstants.defaultPadding),
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
