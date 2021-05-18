import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../../core/constants/AppConstants.dart';
import '../../../../../core/constants/AppFunctions.dart' as AppFunctions;
import '../../../../../data/entities/account_data_entity.dart';
import '../../../../widgets_templates/dialog_template.dart';
import 'dropdown_button_items/choose_color.dart';
import 'dropdown_button_items/choose_color_selected.dart';
import 'dropdown_button_items/choose_image.dart';
import 'dropdown_button_items/choose_image_selected.dart';
import 'dropdown_button_items/default_icon.dart';
import 'dropdown_button_items/default_icon_selected.dart';

typedef void SetIsChosenColorIcon({required bool isChosenColorIcon});

class ChooseIconWidget extends StatefulWidget {
  final Color currentColor;
  final SetIsChosenColorIcon setIsChosenColorIconCallback;
  final BuildContext context;

  ChooseIconWidget({
    Key? key,
    required this.currentColor,
    required this.setIsChosenColorIconCallback,
    required this.context,
  }) : super(key: key);

  @override
  _ChooseIconWidgetState createState() => _ChooseIconWidgetState();
}

class _ChooseIconWidgetState extends State<ChooseIconWidget> {
  late AccountDataEntity _accountDataEntity;
  String _valueSelectedItem = "Choose color";
  bool isShowColorPickerNeeded = false;
  bool isChosenColorIcon = true;
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    _accountDataEntity = Provider.of<AccountDataEntity>(context);
    // _valueSelectedItem = AppLocalizations.of(context)!.chooseColor;

    return Container(
      margin: EdgeInsets.only(
        left: AppConstants.defaultPadding,
        right: AppConstants.defaultPadding,
        top: AppConstants.defaultPadding,
      ),

      /// TODO is it even needed?
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.defaultIconRadius),
        border: Border.all(color: Colors.grey),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          itemHeight:
              AppConstants.defaultIconRadius * 2 + AppConstants.defaultPadding,
          value: _valueSelectedItem,
          selectedItemBuilder: (context) =>
              [
                ChooseImageSelectedDropdownMenuItem(
                  chooseImageIcon: _accountDataEntity.iconWidget!,
                  context: context,
                ),
                ChooseColorSelectedDropdownMenuItem(
                  icon: _accountDataEntity.iconWidget!,
                  context: context,
                ),
              ] +
              dropdownButtonsDefaultIconsSelected(context),
          items: [
                ChooseImageDropdownMenuItem(
                  setIconImageCallback: setIconImage,
                  context: context,
                ),
                ChooseColorDropdownMenuItem(
                  showColorPickerCallback: ({required isShowNeeded}) =>
                      isShowColorPickerNeeded = isShowNeeded,
                  chooseColorIconWidget: _accountDataEntity.iconWidget!,
                  context: context,
                ),
              ] +
              dropdownButtonsDefaultIcons(context),
          onChanged: (String? newValue) {
            setState(() {
              _valueSelectedItem = newValue!;

              if (isShowColorPickerNeeded) {
                showDialog(
                  context: context,
                  builder: (context) => MyDialog(
                    title: "Pick a color",
                    content: Container(
                      // margin: EdgeInsets.all(AppConstants.defaultPadding),
                      // width: MediaQuery.of(context).size.width * 0.8,
                      child: BlockPicker(
                        availableColors: AppConstants.iconDefaultColors,
                        pickerColor: _currentColor,
                        onColorChanged: (value) {
                          setIconColor(color: value);
                        },
                        // availableColors: , TODO wybrać kolory
                      ),
                    ),
                  ),
                  barrierDismissible: false,
                );
                isShowColorPickerNeeded = false;
              }
            });
          },
        ),
      ),
    );
  }

  void setChosenDefaultIconImage(
      {required Image image, required String iconName}) async {
    var temp =
        await rootBundle.load('lib/core/images/${iconName.toLowerCase()}.png');
    Provider.of<AccountDataEntity>(context, listen: false).iconImage =
        temp.buffer.asUint8List();

    setState(() {
      _accountDataEntity.iconWidget = CircleAvatar(
        radius: AppConstants.defaultIconRadius,
        backgroundImage: image.image,
        backgroundColor: Colors.white,
      );
      widget.setIsChosenColorIconCallback(isChosenColorIcon: false);
      // chooseImageIcon = widget.accountData.icon;
    });
  }

  void setIconColor({required Color color}) {
    setState(() {
      _currentColor = color;
      _accountDataEntity.iconWidget =
          AppFunctions.generateRandomColorIconAsWidget(
        name: _accountDataEntity.accountName,
        color: color,
      );
      _accountDataEntity.iconColorHex = color.value.toRadixString(16);
      widget.setIsChosenColorIconCallback(isChosenColorIcon: true);
    });
    Navigator.of(context).pop();
  }

  void setIconImage({required PickedFile pickedFile}) {
    setState(() {
      var image = Image.file(
        File(pickedFile.path),
        width: AppConstants.defaultIconRadius * 2,
        height: AppConstants.defaultIconRadius * 2,
      );

      /// I am not sure it is a safe solution. In theory, this might be not done yet and user is able to save account without iconImage.
      pickedFile.readAsBytes().then((value) =>
          Provider.of<AccountDataEntity>(context, listen: false).iconImage =
              value);
      // Provider.of<AccountDataEntity>(context, listen: false).iconImage = await pickedFile.readAsBytes();

      _accountDataEntity.iconWidget =
          AppFunctions.buildCircleAvatarUsingImage(imageForIcon: image);
      widget.setIsChosenColorIconCallback(isChosenColorIcon: false);
    });
  }

  List<DefaultIconDropdownMenuItem> dropdownButtonsDefaultIcons(
      BuildContext context) {
    return AppConstants.defaultIconsMap.entries
        .map(
          (e) => DefaultIconDropdownMenuItem(
            accountDataEntity: _accountDataEntity,
            mapElement: e,
            setChosenDefaultIconCallback: setChosenDefaultIconImage,
          ),
        )
        .toList();
  }

  List<DefaultIconSelectedDropdownMenuItem> dropdownButtonsDefaultIconsSelected(
      BuildContext context) {
    return AppConstants.defaultIconsMap.entries
        .map(
          (e) => DefaultIconSelectedDropdownMenuItem(
            mapElement: e,
            context: context,
          ),
        )
        .toList();
  }
}
