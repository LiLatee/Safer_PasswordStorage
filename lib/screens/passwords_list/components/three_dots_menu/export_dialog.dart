import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/utils/AppConstants.dart'
    as AppConstants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExportDialog extends StatelessWidget {
  String _secretKey = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MyDialog(
      content: Padding(
        padding: const EdgeInsets.only(
          top: AppConstants.defaultPadding,
          left: AppConstants.defaultPadding,
          right: AppConstants.defaultPadding,
        ),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor)),
                  border: OutlineInputBorder(),
                  labelText: AppLocalizations.of(context)!.secretKey,
                  labelStyle: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onChanged: (value) => _secretKey = value,
                validator: (value) {
                  if (value != null) {
                    if (value.isEmpty) return AppLocalizations.of(context)!.emptySecretKeySnackbar;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      title: AppLocalizations.of(context)!.exportDataDialogTitle,
      buttons: [
        buildCancelButton(context),
        buildExportButton(context, _formKey),
      ],
    );
  }

  MyDialogButton buildCancelButton(BuildContext context) {
    return MyDialogButton(
      buttonName: AppLocalizations.of(context)!.cancel,
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  MyDialogButton buildExportButton(
      BuildContext context, GlobalKey<FormState> formKey) {
    return MyDialogButton(
      buttonName: AppLocalizations.of(context)!.exportData,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          await DataProvider.exportEncryptedDatabase(_secretKey, context)
              .then((AsyncSnapshot<String> value) {
            if (value.hasData) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value.data!)));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(value.error.toString())));
            }
          });
          Navigator.of(context).pop();
        }
      },
    );
  }
}
