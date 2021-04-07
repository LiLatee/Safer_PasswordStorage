import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/utils/AppConstants.dart'
    as AppConstants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            buildSecretKeyForm(_formKey, context),
            buildChooseEncryptedFile(setState),
          ],
        ),
      ),
      buttons: [
        buildCancelButton(context),
        buildImportButton(_formKey, context),
      ],
    );
  }

  MyDialogButton buildCancelButton(BuildContext context) {
    return MyDialogButton(
      buttonName: AppLocalizations.of(context)!.cancel,
      onPressed: () => Navigator.of(context).pop(AsyncSnapshot.nothing()),
    );
  }

  MyDialogButton buildImportButton(
      GlobalKey<FormState> _formKey, BuildContext context) {
    return MyDialogButton(
      buttonName: AppLocalizations.of(context)!.import,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          showDialog(
              context: context,
              builder: (context) => Center(child: CircularProgressIndicator()),
              barrierDismissible: false);

          DataProvider.importEncryptedDatabase(
                  context: context,
                  secretKey: _secretKey!,
                  filepath: _filepath!)
              .then((AsyncSnapshot<String> value) {
            if (value.hasData) {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value.data!)));
            } else {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(value.error.toString())));
            }
          });
        }
      },
    );
  }

  Row buildChooseEncryptedFile(StateSetter setState) {
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

  Form buildSecretKeyForm(GlobalKey<FormState> _formKey, BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).accentColor)),
          border: OutlineInputBorder(),
          labelText: AppLocalizations.of(context)!.secretKey,
          labelStyle: TextStyle(
              color: Theme.of(context).accentColor,
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
