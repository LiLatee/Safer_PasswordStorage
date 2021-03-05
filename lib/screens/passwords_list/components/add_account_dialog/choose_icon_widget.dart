import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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

typedef void SetAccountData({AccountData accountData});
typedef void SetIsChosenColorIcon({bool isChosenColorIcon});
typedef void SetCurrentColor({Color color});

class ChooseIconWidget extends StatefulWidget {
  AccountData accountData;
  SetAccountData setAccountDataCallback;
  Color currentColor;
  final SetIsChosenColorIcon setIsChosenColorIconCallback;

  SetCurrentColor setCurrentColorCallback;

  ChooseIconWidget({
    Key key,
    @required this.accountData,
    @required this.setAccountDataCallback,
    @required this.currentColor,
    @required this.setCurrentColorCallback,
    @required this.setIsChosenColorIconCallback,
  }) : super(key: key);

  @override
  _ChooseIconWidgetState createState() => _ChooseIconWidgetState();
}

class _ChooseIconWidgetState extends State<ChooseIconWidget> {
  String _valueSelectedItem = 'Choose color';
  bool isShowColorPickerNeeded = false;
  Widget chooseColorIcon;
  bool isChosenColorIcon = true;

  void setChosenDefaultIcon({AssetImage image}) {
    setState(() {
      widget.accountData.icon = CircleAvatar(
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
      widget.accountData.icon = MyFunctions.generateRandomColorIcon(
        name: widget.accountData.accountName,
        color: color,
      );
      chooseColorIcon = widget.accountData.icon;
      widget.setCurrentColorCallback(color: color);
      widget.setIsChosenColorIconCallback(isChosenColorIcon: true);
    });
    Navigator.of(context).pop();
  }

  void setIconImage({Image image}) {
    setState(() {
      widget.accountData.icon =
          MyFunctions.buildCircleAvatarUsingImage(imageForIcon: image);
      widget.setIsChosenColorIconCallback(isChosenColorIcon: false);
    });
  }

  List<DefaultIconDropdownMenuItem> dropdownButtonsDefaultIcons(
      BuildContext context) {
    return MyConstants.defaultIconsMap.entries
        .map(
          (e) => DefaultIconDropdownMenuItem(
            accountData: widget.accountData,
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

  @override
  Widget build(BuildContext context) {
    chooseColorIcon = MyFunctions.generateRandomColorIcon(
      name: widget.accountData.accountName,
      color: widget.currentColor,
    );

    return Container(
      margin: EdgeInsets.only(
          left: MyConstants.defaultPadding,
          right: MyConstants.defaultPadding,
          top: MyConstants.defaultPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MyConstants.defaultIconRadius),
          border: Border.all(color: Colors.grey)),
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
                    chooseImageIcon: widget.accountData.icon),
                ChooseColorSelectedDropdownMenuItem(
                    icon: widget.accountData.icon),
              ] +
              dropdownButtonsDefaultIconsSelected(context),
          items: [
                ChooseImageDropdownMenuItem(
                  setIconImageCallback: setIconImage,
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
                    ), barrierDismissible: false,
                    context: context);
                isShowColorPickerNeeded = false;
              }
            });
          },
        ),
      ),
    );
  }
}
