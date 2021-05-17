import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/general/export_data_cubit.dart';

import '../../../../../core/constants/AppConstants.dart';
import '../../../../widgets_templates/dialog_template.dart';

class ExportDialog extends StatefulWidget {
  final BuildContext superContext;

  ExportDialog({Key? key, required this.superContext}) : super(key: key);

  @override
  _ExportDialogState createState() => _ExportDialogState();
}

class _ExportDialogState extends State<ExportDialog> {
  String _secretKey = '';

  final _formKey = GlobalKey<FormState>();
  bool hideText = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExportDataCubit, ExportDataState>(
      listener: (context, state) {
        if (state is ExportedData) {
          Navigator.of(context).pop(); // Close loading screen.
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!
                  .exportSuccess(state.exportedDataLocation))));
        } else if (state is ExportError) {
          Navigator.of(context).pop(); // Close loading screen.

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(AppLocalizations.of(context)!.encryptionError +
                  " ${state.toString()}")));
        }
      },
      builder: (context, state) {
        if (state is ExportingData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return MyDialog(
          content: Padding(
            padding: const EdgeInsets.only(
              top: AppConstants.defaultPadding,
              left: AppConstants.defaultPadding,
              right: AppConstants.defaultPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: secretKeyForm(context: context),
                ),
                buildShowHideTextButton(),
              ],
            ),
          ),
          title: AppLocalizations.of(context)!.exportDataDialogTitle,
          buttons: [
            buildCancelButton(context),
            buildExportButton(context, _formKey),
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

  Widget buildExportButton(BuildContext context, GlobalKey<FormState> formKey) {
    return MyDialogButton(
      buttonName: AppLocalizations.of(context)!.exportData,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          BlocProvider.of<ExportDataCubit>(widget.superContext)
              .exportData(secretKey: _secretKey);
        }
      },
    );
  }

  Widget secretKeyForm({required BuildContext context}) {
    return Form(
      key: _formKey,
      child: TextFormField(
        obscureText: hideText,
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
                    color: hideText
                        ? Theme.of(context).colorScheme.onBackground
                        : Theme.of(context).colorScheme.background,
                  ),
                  SizedBox(
                    width: AppConstants.defaultPadding,
                  ),
                  Text(
                    AppLocalizations.of(context)!.showHiddenFields,
                    style: TextStyle(
                        color: hideText
                            ? Theme.of(context).colorScheme.onBackground
                            : Theme.of(context).colorScheme.background),
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
