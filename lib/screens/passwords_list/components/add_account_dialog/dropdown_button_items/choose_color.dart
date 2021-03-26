import 'package:flutter/material.dart';
import '../../../../../utils/AppConstants.dart' as MyConstants;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef void ShowColorPicker({required bool isShowNeeded});

class ChooseColorDropdownMenuItem extends DropdownMenuItem<String> {
  final ShowColorPicker showColorPickerCallback;
  final Widget chooseColorIconWidget;
  final BuildContext context;

  ChooseColorDropdownMenuItem({
    Key? key,
    required this.chooseColorIconWidget,
    required this.showColorPickerCallback,
    required this.context
  }) : super(
            onTap: () {
              showColorPickerCallback(isShowNeeded: true);
            },
            value: "Choose color",
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: MyConstants.defaultPadding),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        chooseColorIconWidget,
                        SizedBox(
                          width: MyConstants.defaultPadding,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.chooseColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: MyConstants.defaultPadding),
                  child: Divider(
                    color: Colors.black,
                    height: 1,
                  ),
                ),
              ],
            ));
}
