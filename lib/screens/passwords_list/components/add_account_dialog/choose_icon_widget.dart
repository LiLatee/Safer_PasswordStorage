import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:provider/provider.dart';

import '../../../../components/dialog_template.dart';
import '../../../../models/account_data.dart';
import '../../../../utils/constants.dart' as MyConstants;
import '../../../../utils/functions.dart' as MyFunctions;
import 'dropdown_button_items/choose_color.dart';
import 'dropdown_button_items/choose_color_selected.dart';
import 'dropdown_button_items/choose_image.dart';
import 'dropdown_button_items/choose_image_selected.dart';
import 'dropdown_button_items/default_icon.dart';
import 'dropdown_button_items/default_icon_selected.dart';

// typedef void SetAccountDataEntity({AccountDataEntity accountDataEntity});
typedef void SetIsChosenColorIcon({bool isChosenColorIcon});
// typedef void SetCurrentColor({Color color});

class ChooseIconWidget extends StatefulWidget {
  // SetAccountDataEntity setAccountDataCallback;
  Color currentColor;
  final SetIsChosenColorIcon setIsChosenColorIconCallback;

  // SetCurrentColor setCurrentColorCallback;

  ChooseIconWidget({
    Key key,
    // @required this.setAccountDataCallback,
    // @required this.currentColor,
    // @required this.setCurrentColorCallback,
    @required this.setIsChosenColorIconCallback,
  }) : super(key: key);

  @override
  _ChooseIconWidgetState createState() => _ChooseIconWidgetState();
}

class _ChooseIconWidgetState extends State<ChooseIconWidget> {
  AccountDataEntity _accountDataEntity;
  String _valueSelectedItem = 'Choose color';
  bool isShowColorPickerNeeded = false;
  Widget chooseColorIcon;
  bool isChosenColorIcon = true;

  @override
  Widget build(BuildContext context) {
    _accountDataEntity = Provider.of<AccountDataEntity>(context);

    chooseColorIcon = MyFunctions.generateRandomColorIcon(
      name: _accountDataEntity.accountName,
      color: widget.currentColor,
    );

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
        child: DropdownButton(
          isExpanded: true,
          itemHeight:
              MyConstants.defaultIconRadius * 2 + MyConstants.defaultPadding,
          value: _valueSelectedItem,
          selectedItemBuilder: (context) =>
              [
                ChooseImageSelectedDropdownMenuItem(
                    chooseImageIcon: _accountDataEntity.iconWidget),
                ChooseColorSelectedDropdownMenuItem(
                    icon: _accountDataEntity.iconWidget),
              ] +
              dropdownButtonsDefaultIconsSelected(context),
          items: [
                ChooseImageDropdownMenuItem(
                  setIconImageCallback: setIconImage,
                  context: context,
                ),
                ChooseColorDropdownMenuItem(
                  showColorPickerCallback: ({isShowNeeded}) =>
                      isShowColorPickerNeeded = isShowNeeded,
                  chooseColorIcon: chooseColorIcon,
                ),
              ] +
              dropdownButtonsDefaultIcons(context),
          onChanged: (value) {
            setState(() {
              _valueSelectedItem = value;

              if (isShowColorPickerNeeded) {
                showDialog(
                    builder: (context) => MyDialog(
                          title: 'Pick a color',
                          content: Container(
                            margin: EdgeInsets.all(MyConstants.defaultPadding),
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: BlockPicker(
                              availableColors: MyConstants.iconDefaultColors,
                              pickerColor: widget.currentColor,
                              onColorChanged: (value) {
                                setIconColor(color: value);
                              },
                              // availableColors: , TODO wybrać kolory
                            ),
                          ),
                        ),
                    barrierDismissible: false,
                    context: context);
                isShowColorPickerNeeded = false;
              }
            });
          },
        ),
      ),
    );
  }

  void setChosenDefaultIcon({AssetImage image}) {
    setState(() {
      _accountDataEntity.iconWidget = CircleAvatar(
        radius: MyConstants.defaultIconRadius,
        backgroundImage: image,
        backgroundColor: Colors.transparent,
      );
      widget.setIsChosenColorIconCallback(isChosenColorIcon: false);
      // chooseImageIcon = widget.accountData.icon;
    });
  }

  void setIconColor({Color color}) {
    setState(() {
      widget.currentColor = color;
      _accountDataEntity.iconWidget = MyFunctions.generateRandomColorIcon(
        name: _accountDataEntity.accountName,
        color: color,
      );
      _accountDataEntity.iconColorHex = color.value.toRadixString(16);
      chooseColorIcon = _accountDataEntity.iconWidget;
      // widget.setCurrentColorCallback(color: color);
      widget.setIsChosenColorIconCallback(isChosenColorIcon: true);
    });
    Navigator.of(context).pop();
  }

  void setIconImage({Image image}) {
    setState(() {
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
            setChosenDefaultIconCallback: setChosenDefaultIcon,
          ),
        )
        .toList();
  }

  List<DefaultIconSelectedDropdownMenuItem> dropdownButtonsDefaultIconsSelected(
      BuildContext context) {
    return MyConstants.defaultIconsMap.entries
        .map(
          (e) => DefaultIconSelectedDropdownMenuItem(mapElement: e),
        )
        .toList();
  }
}
