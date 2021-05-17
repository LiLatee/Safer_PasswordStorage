import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account/edit_single_account_cubit.dart';

import '../../../../../../core/constants/AppConstants.dart';
import '../../../../../../data/models/account_data_entity.dart';
import '../../../../../../data/models/field_data_entity.dart';
import '../../../../../../logic/cubit/single_account/add_field_cubit.dart';
import '../../../../../widgets_templates/dialog_template.dart';
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
    var editSingleAccountCubitState =
        context.watch<EditSingleAccountCubit>().state;

    return ButtonTemplate(
        onPressed: editSingleAccountCubitState is EditedSingleAccount
            ? null
            : () async {
                // TODO try to refactor Dialog to make some methods
                var result = await showDialog(
                  context: context,
                  builder: (context) {
                    var _nameFormKey = GlobalKey<FormState>();
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
                                  bottom: AppConstants.defaultPadding,
                                ),
                                child: Form(
                                  key: _nameFormKey,
                                  child: TextFormField(
                                    autofocus: true,
                                    // key: ObjectKey(AppLocalizations.of(context)!
                                    //     .name), // TODO potrzebne?
                                    readOnly: false,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => name = value,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText:
                                          AppLocalizations.of(context)!.name,
                                    ),
                                    validator: (value) {
                                      if (value != null && value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .emptyAccountNameValidator;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              Form(
                                child: TextFormField(
                                  // key: ObjectKey(AppLocalizations.of(context)!
                                  //     .content), // TODO potrzebne?
                                  readOnly: false,
                                  maxLines: isMultiline == true ? null : 1,
                                  obscureText: isHidden,
                                  textInputAction: isMultiline
                                      ? TextInputAction.newline
                                      : TextInputAction.done,
                                  keyboardType: isMultiline
                                      ? TextInputType.multiline
                                      : TextInputType.text,
                                  onChanged: (newValue) => value = newValue,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText:
                                        AppLocalizations.of(context)!.content,
                                  ),
                                ),
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
                              if (_nameFormKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            AppLocalizations.of(context)!
                                                .addedFieldSnackbar(name))));
                                Navigator.of(context).pop({
                                  "name": name,
                                  "value": value,
                                  "isHidden": isHidden,
                                  "isMultiline": isMultiline,
                                });
                              }
                            },
                          )
                        ],
                      ),
                    );
                  },
                );

                if (result != null)
                  BlocProvider.of<AddFieldCubit>(context).addField(
                      fieldDataEntity: FieldDataEntity(
                    accountId: _accountDataEntity.uuid!,
                    name: result['name'],
                    value: result['value'],
                    isHidden: result['isHidden'],
                    isMultiline: result['isMultiline'],
                  ));
              },
        icon: Icons.add,
        label: AppLocalizations.of(context)!.addField);
  }
}
