import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../core/constants/AppConstants.dart';
import '../../../../../logic/cubit/import_data_cubit.dart';
import '../../../../widgets_templates/dialog_template.dart';

class ImportDialog extends StatefulWidget {
  @override
  _ImportDialogState createState() => _ImportDialogState();
}

class _ImportDialogState extends State<ImportDialog> {
  String? _secretKey;
  String? _filepath;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _filepath ??= AppLocalizations.of(context)!.chooseEncryptedFile;

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
            buildSecretKeyForm(context),
            buildChooseEncryptedFile(),
          ],
        ),
      ),
      buttons: [
        buildCancelButton(context),
        buildImportButton(context),
      ],
    );
  }

  MyDialogButton buildCancelButton(BuildContext context) {
    return MyDialogButton(
      buttonName: AppLocalizations.of(context)!.cancel,
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget buildImportButton(BuildContext context) {
    return BlocConsumer<ImportDataCubit, ImportDataState>(
      listener: (context, state) {
        if (state is ImportedData) {
          Navigator.of(context).pop(); // Close loading screen.
          Navigator.of(context).pop(); // Back to HomeScreen.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.importSuccess)));
        } else if (state is ImportError) {
          Navigator.of(context).pop(); // Close loading screen.
          Navigator.of(context).pop(); // Back to HomeScreen.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.decryptionFailed)));
        }
      },
      builder: (context, state) {
        return MyDialogButton(
          buttonName: AppLocalizations.of(context)!.import,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              // Loading screen.
              showDialog(
                context: context,
                builder: (context) =>
                    Center(child: CircularProgressIndicator()),
                barrierDismissible: false,
              );

              BlocProvider.of<ImportDataCubit>(context).importData(
                secretKey: _secretKey!,
                filepath: _filepath!,
              );
            }
          },
        );
      },
    );
  }

  Row buildChooseEncryptedFile() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: AppConstants.defaultPadding),
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
              child: Icon(Icons.file_upload)),
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Text(
            _filepath ?? AppLocalizations.of(context)!.chooseEncryptedFile,
          ),
          scrollDirection: Axis.horizontal,
        )),
      ],
    );
  }

  Form buildSecretKeyForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
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
}
