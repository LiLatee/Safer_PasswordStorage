import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../../components/account_name_field_widget.dart';
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

class AddAccountDialog extends StatefulWidget {
  final Function addAccountCallback;
  final List<AccountData> currentAccounts;

  AddAccountDialog({
    @required this.addAccountCallback,
    @required this.currentAccounts,
  });

  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}

class _AddAccountDialogState extends State<AddAccountDialog> {
  AccountData accountData = AccountData(accountName: 'Account name');
  final accountNameFormKey = GlobalKey<FormState>();
  Color currentColor = MyConstants.iconDefaultColors[0];
  // Widget chooseImageIcon;
  // Widget chooseColorIcon;
  bool isChosenColorIcon = true;

  void setAccountName({String accountName}) {
    setState(() {
      accountData.accountName = accountName;
      if (isChosenColorIcon) {
        accountData.icon = MyFunctions.generateRandomColorIcon(
          name: accountData.accountName,
          color: currentColor,
        );
      }
    });
  }

  // void setIconImage({Image image}) {
  //   setState(() {
  //     accountData.icon =
  //         MyFunctions.buildCircleAvatarUsingImage(imageForIcon: image);
  //     chooseImageIcon = accountData.icon;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MyDialog(
      content: Column(
        children: <Widget>[
          AccountNameFieldWidget(
            currentAccounts: widget.currentAccounts,
            onChangedCallback: setAccountName,
            accountNameFormKey: accountNameFormKey,
          ),
          ChooseIconWidget(
            accountData: accountData,
            setAccountDataCallback: ({accountData}) =>
                this.accountData = accountData,
            setIsChosenColorIconCallback: ({isChosenColorIcon}) =>
                this.isChosenColorIcon = isChosenColorIcon,
            currentColor: currentColor,
            setCurrentColorCallback: ({color}) => currentColor = color,
          ),
          bottomButtonsSection(context)
        ],
      ),
      title: "Adding new account",
    );
  }

  Widget chooseIconImage(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        Size size = MediaQuery.of(context).size;
        double rowHeight =
            MyConstants.defaultIconRadius * 2 + MyConstants.defaultPadding;
        double minHeightNeeded = MyConstants.defaultIcons.length * rowHeight +
            MyConstants.defaultPadding;

        showDialog(
            barrierDismissible: false,
            context: context,
            child: MyDialog(
              title: 'Pick an icon',
              content: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(top: MyConstants.defaultPadding),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: minHeightNeeded < size.height * 0.8
                        ? minHeightNeeded
                        : size.height * 0.8,
                    child: ListView.builder(
                        itemCount: MyConstants.defaultIcons.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: MyConstants.defaultPadding,
                                right: MyConstants.defaultPadding,
                                bottom: MyConstants.defaultPadding),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: MyConstants.defaultIconRadius,
                                  backgroundImage:
                                      MyConstants.defaultIcons[index].image,
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(
                                  width: MyConstants.defaultPadding,
                                ),
                                Text(MyConstants.defaultIconsNames[index])
                              ],
                            ),
                          );
                        })),
              ),
            ));

        // File file = await FilePicker.getFile(type: FileType.image);
        // changeIconImage(Image.asset(file.path,
        //     width: MyConstants.defaultIconRadius * 2,
        //     height: MyConstants.defaultIconRadius * 2));
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: Theme.of(context).accentColor,
          width: 2.0,
        ),
      ),
      child: Container(
        child: Text(
          "Choose image",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
    );
  }

  Widget bottomButtonsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MyConstants.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  child: Text(
                    "Cancel",
                  ),
                ),
              ),
            ),
            VerticalDivider(color: Theme.of(context).primaryColor),
            Expanded(
              child: FlatButton(
                onPressed: () {
                  if (accountNameFormKey.currentState.validate()) {
                    // if (chooseImageIcon == null) {
                    //   accountData.icon = chooseColorIcon;
                    // }
                    widget.addAccountCallback(accountData: accountData);
                    Navigator.of(context).pop();
                  } else {
                    // Scaffold.of(context)
                    //     .showSnackBar(SnackBar(content: Text('zle')));
                  }
                },
                child: Container(
                  child: Text("Add"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// typedef void ShowColorPicker({bool isShowNeeded});
// typedef void SetIconImage({Image image});
// typedef void SetIconColor({Color color});
// typedef void SetChosenDefaultIcon({AssetImage image});
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
      widget.setIsChosenColorIconCallback(isChosenColorIcon: true);
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

    return Padding(
      padding: EdgeInsets.only(
        top: MyConstants.defaultPadding,
      ),
      child: Container(
        padding: EdgeInsets.all(MyConstants.defaultPadding),
        width: MediaQuery.of(context).size.width * 0.8,
        child: DropdownButton(
          isExpanded: true,
          itemHeight:
              MyConstants.defaultIconRadius * 2 + MyConstants.defaultPadding,
          underline: Container(),
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
                    barrierDismissible: false,
                    context: context,
                    child: MyDialog(
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
                    ));
                isShowColorPickerNeeded = false;
              }
            });
          },
        ),
      ),
    );
  }
}
