import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/constants/AppConstants.dart' as AppConstants;
import '../../../../../../data/models/account_data_entity.dart';
import '../../../../../../data/models/field_data_entity.dart';
import '../../../../../../logic/cubit/single_account_cubit.dart';
import '../../../../../widgets_templates/dialog_template.dart';
import '../../../../../widgets_templates/field_widget.dart';
import 'button_template.dart';

class ButtonAddField extends StatelessWidget {
  final AccountDataEntity _accountDataEntity;

  ButtonAddField({
    Key? key,
    required AccountDataEntity accountDataEntity,
  })   : _accountDataEntity = accountDataEntity,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTemplate(
        onPressed: () async {
          // if (!_accountDataEntity.isEditButtonPressed)
          //   _dataProvider.toggleEditButton(
          //       accountDataEntity: _accountDataEntity);

          var result = await showDialog(
            context: context,
            builder: (context) {
              bool isHidden = false;
              bool isMultiline = false;
              var name;
              var value = "";
              return StatefulBuilder(
                builder: (context, setState) => MyDialog(
                  title: AppLocalizations.of(context)!.addNewFieldTitle,
                  content: Padding(
                    padding: const EdgeInsets.only(
                        top: AppConstants.defaultPadding,
                        left: AppConstants.defaultPadding,
                        right: AppConstants.defaultPadding),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: AppConstants.defaultPadding),
                          child: AdditionalFieldWidget(
                            label: AppLocalizations.of(context)!.name,
                            readOnly: false,
                            value: "",
                            onChangedCallback: ({required newText}) =>
                                name = newText,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        AdditionalFieldWidget(
                          label: AppLocalizations.of(context)!.content,
                          readOnly: false,
                          value: "",
                          onChangedCallback: ({required newText}) =>
                              value = newText,
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
                            Text(AppLocalizations.of(context)!
                                .makeHiddenFieldQuestion),
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
                            Text(AppLocalizations.of(context)!
                                .makeMultilineFieldQuestion),
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
                        buttonName: AppLocalizations.of(context)!.cancel,
                        onPressed: () => Navigator.of(context).pop(null)),
                    MyDialogButton(
                      buttonName: AppLocalizations.of(context)!.add,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(AppLocalizations.of(context)!
                                .addedFieldSnackbar(name))));
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
            BlocProvider.of<SingleAccountCubit>(context).addField(
                fieldDataEntity: FieldDataEntity(
              accountId: _accountDataEntity.uuid!,
              name: result['name'],
              value: result['value'],
              isHidden: result['isHidden'],
              isMultiline: result['isMultiline'],
            ));

          // DataProvider.addField(
          //   FieldDataEntity(
          //     accountId: _accountDataEntity.uuid!,
          //     name: result['name'],
          //     value: result['value'],
          //     isHidden: result['isHidden'],
          //     isMultiline: result['isMultiline'],
          //   ),
          // );

          /// If using AnimatedList instead of ReorderableListView
          // account.listKey.currentState.insertItem(account.getNumberOfFields - 1,
          //     duration: AppConstants.animationsDuration);
        },
        icon: Icons.add,
        label: AppLocalizations.of(context)!.addField);
  }
}
