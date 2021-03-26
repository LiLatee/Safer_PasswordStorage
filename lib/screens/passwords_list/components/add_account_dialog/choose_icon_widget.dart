import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:provider/provider.dart';

import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/utils/AppConstants.dart' as MyConstants;
import 'package:mysimplepasswordstorage/utils/functions.dart' as MyFunctions;
import 'dropdown_button_items/choose_color.dart';
import 'dropdown_button_items/choose_color_selected.dart';
import 'dropdown_button_items/choose_image.dart';
import 'dropdown_button_items/choose_image_selected.dart';
import 'dropdown_button_items/default_icon.dart';
import 'dropdown_button_items/default_icon_selected.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        left: MyConstants.defaultPadding,
        right: MyConstants.defaultPadding,
        top: MyConstants.defaultPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyConstants.defaultIconRadius),
        border: Border.all(color: Colors.grey),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          itemHeight:
              MyConstants.defaultIconRadius * 2 + MyConstants.defaultPadding,
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
                      // margin: EdgeInsets.all(MyConstants.defaultPadding),
                      // width: MediaQuery.of(context).size.width * 0.8,
                      child: BlockPicker(
                        availableColors: MyConstants.iconDefaultColors,
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
    var temp = await rootBundle.load('images/${iconName.toLowerCase()}.png');
    Provider.of<AccountDataEntity>(context, listen: false).iconImage =
        temp.buffer.asUint8List();

    setState(() {
      _accountDataEntity.iconWidget = CircleAvatar(
        radius: MyConstants.defaultIconRadius,
        backgroundImage: image.image,
        backgroundColor: Colors.transparent,
      );
      widget.setIsChosenColorIconCallback(isChosenColorIcon: false);
      // chooseImageIcon = widget.accountData.icon;
    });
  }

  void setIconColor({required Color color}) {
    setState(() {
      _currentColor = color;
      _accountDataEntity.iconWidget =
          MyFunctions.generateRandomColorIconAsWidget(
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
        width: MyConstants.defaultIconRadius * 2,
        height: MyConstants.defaultIconRadius * 2,
      );

      /// I am not sure it is a safe solution. In theory, this might be not done yet and user is able to save account without iconImage.
      pickedFile.readAsBytes().then((value) =>
          Provider.of<AccountDataEntity>(context, listen: false).iconImage =
              value);
      // Provider.of<AccountDataEntity>(context, listen: false).iconImage = await pickedFile.readAsBytes();

      _accountDataEntity.iconWidget =
          MyFunctions.buildCircleAvatarUsingImage(imageForIcon: image);
      widget.setIsChosenColorIconCallback(isChosenColorIcon: false);
    });
  }

  List<DefaultIconDropdownMenuItem> dropdownButtonsDefaultIcons(
      BuildContext context) {
    return MyConstants.defaultIconsMap.entries
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
    return MyConstants.defaultIconsMap.entries
        .map(
          (e) => DefaultIconSelectedDropdownMenuItem(
            mapElement: e,
            context: context,
          ),
        )
        .toList();
  }
}
