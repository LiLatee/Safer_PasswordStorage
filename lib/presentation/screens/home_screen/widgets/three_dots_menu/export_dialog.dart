import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../../logic/cubit/export_data_cubit.dart';

import '../../../../../core/constants/AppConstants.dart';
import '../../../../widgets_templates/dialog_template.dart';

class ExportDialog extends StatelessWidget {
  String _secretKey = '';
  final _formKey = GlobalKey<FormState>();
  final BuildContext superContext;

  ExportDialog({Key? key, required this.superContext}) : super(key: key);

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
            secretKeyForm(context: context),
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

  Widget buildExportButton(BuildContext context, GlobalKey<FormState> formKey) {
    return BlocConsumer<ExportDataCubit, ExportDataState>(
      listener: (context, state) {
        if (state is ExportedData) {
          Navigator.of(context).pop(); // Close loading screen.
          Navigator.of(context).pop(); // Back to HomeScreen.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!
                  .exportSuccess(state.exportedDataLocation))));
        } else if (state is ExportError) {
          Navigator.of(context).pop(); // Close loading screen.
          Navigator.of(context).pop(); // Back to HomeScreen.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.encryptionError)));
        }
      },
      builder: (context, state) {
        return MyDialogButton(
          buttonName: AppLocalizations.of(context)!.exportData,
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // Loading screen.
              showDialog(
                context: context,
                builder: (context) =>
                    Center(child: CircularProgressIndicator()),
                barrierDismissible: false,
              );

              BlocProvider.of<ExportDataCubit>(superContext)
                  .exportData(secretKey: _secretKey);

              //     .then((AsyncSnapshot<String> value) {
              //   if (value.hasData) {
              //     ScaffoldMessenger.of(context)
              //         .showSnackBar(SnackBar(content: Text(value.data!)));
              //   } else {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text(value.error.toString())));
              //   }
              // });

              // await DataProvider.exportEncryptedDatabase(_secretKey, context)
              //     .then((AsyncSnapshot<String> value) {
              //   if (value.hasData) {
              //     ScaffoldMessenger.of(context)
              //         .showSnackBar(SnackBar(content: Text(value.data!)));
              //   } else {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text(value.error.toString())));
              //   }
              // });

              // await DataProvider.exportEncryptedDatabase(_secretKey, context)
              //     .then((AsyncSnapshot<String> value) {
              //   if (value.hasData) {
              //     ScaffoldMessenger.of(context)
              //         .showSnackBar(SnackBar(content: Text(value.data!)));
              //   } else {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text(value.error.toString())));
              //   }
              // });
              // Navigator.of(context).pop(); // TODO
            }
          },
        );
      },
    );
  }

  Widget secretKeyForm({required BuildContext context}) {
    return Form(
      key: _formKey,
      child: TextFormField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  // color: Theme.of(context).accentColor,
                  )),
          border: OutlineInputBorder(),
          labelText: AppLocalizations.of(context)!.secretKey,
          labelStyle: TextStyle(
            // color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
          ),
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
