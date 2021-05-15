import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/import_data_cubit.dart';

import '../../../../../core/constants/AppConstants.dart';
import '../../../../widgets_templates/dialog_template.dart';

class ImportDialog extends StatefulWidget {
  @override
  _ImportDialogState createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  String? _secretKey;
  String? _filepath;
  final _formKey = GlobalKey<FormState>();
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    _filepath ??= AppLocalizations.of(context)!.chooseEncryptedFile;

    return BlocConsumer<ImportDataCubit, ImportDataState>(
      listener: (context, state) {
        if (state is ImportingData) {
          log("importing - listener");
        }
        if (state is ImportedData) {
          Navigator.of(context).pop(); // Close loading screen.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.importSuccess)));
        } else if (state is ImportError) {
          Navigator.of(context).pop(); // Close loading screen.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.decryptionFailed)));
        }
      },
      builder: (context, state) {
        if (state is ImportingData) {
          return Center(child: CircularProgressIndicator());
        }
        return MyDialog(
          title: AppLocalizations.of(context)!.importDataDialogTitle,
          content: Padding(
            padding: const EdgeInsets.only(
              top: AppConstants.defaultPadding,
              left: AppConstants.defaultPadding,
              right: AppConstants.defaultPadding,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: buildSecretKeyForm(context)),
                    buildShowHideTextButton(),
                  ],
                ),
                buildChooseEncryptedFile(),
              ],
            ),
          ),
          buttons: [
            buildCancelButton(context),
            buildImportButton(context),
          ],
        );
      },
    );
  }

  MyDialogButton buildCancelButton(BuildContext context) {
    return MyDialogButton(
      buttonName: AppLocalizations.of(context)!.cancel,
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget buildImportButton(BuildContext context) {
    return MyDialogButton(
      buttonName: AppLocalizations.of(context)!.import,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<ImportDataCubit>(context).importData(
            secretKey: _secretKey!,
            filepath: _filepath!,
          );
        }
      },
    );
  }

  Widget buildChooseEncryptedFile() {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: AppConstants.defaultPadding),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1.0,
                      color: Theme.of(context).colorScheme.primary)),
            ),
            child: TextButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowMultiple: false,
                  type: FileType.custom,
                  allowedExtensions: ['bin'],
                );
                if (result != null) {
                  log(result.files.single.path!);
                  setState(() => _filepath = result.files.single.path);
                }
              },
              child: Icon(Icons.file_upload),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Text(
              _filepath ?? AppLocalizations.of(context)!.chooseEncryptedFile,
              overflow: TextOverflow.ellipsis,
            ),
            scrollDirection: Axis.horizontal,
          )),
        ],
      ),
    );
  }

  Form buildSecretKeyForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        obscureText: hideText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                // color: Theme.of(context).accentColor,
                ),
          ),
          border: OutlineInputBorder(),
          labelText: AppLocalizations.of(context)!.secretKey,
          labelStyle: TextStyle(
              // color: Theme.of(context).accentColor,
              fontWeight: FontWeight.bold),
        ),
        onChanged: (value) => _secretKey = value,
        validator: (value) {
          if (value != null) {
            if (value.isEmpty)
              return AppLocalizations.of(context)!.emptySecretKeySnackbar;
          }
          return null;
        },
      ),
    );
  }

  buildShowHideTextButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(left: AppConstants.defaultPadding),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              AppConstants.defaultCircularBorderRadius,
            ),
            onTap: () {
              setState(() {
                hideText = !hideText;
              });
            },
            child: AnimatedContainer(
              duration: AppConstants.animationsDuration,
              padding: const EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  AppConstants.defaultCircularBorderRadius,
                ),
                color: hideText
                    ? Theme.of(context).colorScheme.background.withOpacity(0.05)
                    : Theme.of(context).colorScheme.secondary,
              ),
              child: Row(
                children: [
                  Icon(
                    hideText
                        ? Icons.remove_red_eye_outlined
                        : Icons.remove_red_eye,
                    color: hideText ? Colors.white : Colors.black,
                  ),
                  SizedBox(
                    width: AppConstants.defaultPadding,
                  ),
                  Text(
                    AppLocalizations.of(context)!.showHiddenFields,
                    style: TextStyle(
                        color: hideText ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
