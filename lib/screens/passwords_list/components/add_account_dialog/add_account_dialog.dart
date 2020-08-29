import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mysimplepasswordstorage/components/account_name_field_widget.dart';
import 'package:mysimplepasswordstorage/components/dialog_template.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';

import '../../../../utils/constants.dart' as Constants;
import '../../../../utils/functions.dart' as MyFunctions;

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
  Color currentColor = Constants.iconDefaultColors[0];
  Widget chooseImageIcon;
  Widget chooseColorIcon;
  bool isImageChosen = false;
  bool isShowDialogNeeded = false;

  void changeAccountName({String accountName}) {
    setState(() {
      this.accountData.accountName = accountName;
      if (!isImageChosen) {
        accountData.icon = MyFunctions.generateRandomColorIcon(
          name: accountData.accountName,
          color: currentColor,
        );
        chooseColorIcon = accountData.icon;
      }
    });
  }

  void changeIconColor(Color newColor) {
    setState(() {
      currentColor = newColor;
      accountData.icon = MyFunctions.generateRandomColorIcon(
        name: accountData.accountName,
        color: newColor,
      );
    });
    chooseColorIcon = accountData.icon;
    isImageChosen = false;
    Navigator.of(context).pop();
  }

  void changeIconImage(Image newImage) {
    setState(() {
      accountData.icon =
          MyFunctions.buildCircleAvatarUsingImage(imageForIcon: newImage);
    });
    chooseImageIcon = accountData.icon;
    isImageChosen = true;
    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MyDialog(
      content: combinedContent(context),
      title: "Adding new account",
    );
  }

  Widget combinedContent(BuildContext context) {
    return Column(
      children: <Widget>[
        AccountNameFieldWidget(
          currentAccounts: widget.currentAccounts,
          onChangedCallback: changeAccountName,
          accountNameFormKey: accountNameFormKey,
        ),
        chooseIconSection(context),
        bottomButtonsSection(context)
      ],
    );
  }

  String _value = Constants.defaultIconsNames[0];
  Widget chooseIconSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Constants.defaultPadding,
      ),
      child: Container(
        padding: EdgeInsets.all(Constants.defaultPadding),
        width: MediaQuery.of(context).size.width * 0.8,
        child: DropdownButton(
          onTap: () {
            if (isImageChosen) {
              setState(() {
                isImageChosen = false;
                // Navigator.pop(context);
              });
            }
          },
          isExpanded: true,
          itemHeight:
              Constants.defaultIconRadius * 2 + Constants.defaultPadding,
          underline: Container(),
          value: _value,
          items: [
                isImageChosen
                    ? dropdownButtonChooseImageWithoutGesture()
                    : dropdownButtonChooseImage(),
                dropdownButtonChooseColor(),
              ] +
              dropdownButtonsDefaultIcons(context),
          onChanged: (value) {
            setState(() {
              _value = value;
              if (isShowDialogNeeded) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    child: MyDialog(
                      title: 'Pick a color',
                      content: Container(
                        margin: EdgeInsets.all(Constants.defaultPadding),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: BlockPicker(
                          availableColors: Constants.iconDefaultColors,
                          pickerColor: currentColor,
                          onColorChanged: (value) {
                            changeIconColor(value);
                          },
                          // availableColors: , TODO wybrać kolory
                        ),
                      ),
                    ));
                isShowDialogNeeded = false;
              }
            });
          },
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> dropdownButtonsDefaultIcons(
      BuildContext context) {
    return Constants.defaultIconsMap.entries
        .map(
          (e) => DropdownMenuItem(
            child: Padding(
              padding: EdgeInsets.only(bottom: Constants.defaultPadding),
              child: IntrinsicHeight(
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: Constants.defaultIconRadius,
                      backgroundImage: e.value.image,
                      backgroundColor: Colors.transparent,
                    ),
                    SizedBox(
                      width: Constants.defaultPadding,
                    ),
                    Text(
                      e.key,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            value: e.key,
          ),
        )
        .toList();
  }

  DropdownMenuItem<String> dropdownButtonChooseColor() {
    return DropdownMenuItem(
        onTap: () {
          isShowDialogNeeded = true;
          // showDialog(
          //     barrierDismissible: false,
          //     context: context,
          //     child: MyDialog(
          //       title: 'Pick a color',
          //       content: Container(
          //         margin: EdgeInsets.all(Constants.defaultPadding),
          //         width: MediaQuery.of(context).size.width * 0.8,
          //         child: BlockPicker(
          //           availableColors: Constants.iconDefaultColors,
          //           pickerColor: currentColor,
          //           onColorChanged: (value) {
          //             changeIconColor(value);
          //             Navigator.of(context).pop();
          //           },
          //           // availableColors: , TODO wybrać kolory
          //         ),
          //       ),
          //     ));
        },
        value: 'Choose color',
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: Constants.defaultPadding),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    chooseColorIcon ??
                        MyFunctions.generateRandomColorIcon(
                          color: currentColor,
                          name: accountData.accountName,
                        ),
                    SizedBox(
                      width: Constants.defaultPadding,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Choose color',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(bottom: Constants.defaultPadding),
            //   child: Divider(
            //     color: Colors.black,
            //     height: 1,
            //   ),
            // ),
          ],
        ));
  }

  DropdownMenuItem<String> dropdownButtonChooseImage() {
    return DropdownMenuItem(
        onTap: () async {
          File file = await FilePicker.getFile(type: FileType.image);
          changeIconImage(Image.asset(file.path,
              width: Constants.defaultIconRadius * 2,
              height: Constants.defaultIconRadius * 2));
        },
        value: 'Choose image',
        child: Container(
          margin: EdgeInsets.only(bottom: Constants.defaultPadding),
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                chooseImageIcon ??
                    Icon(
                      Icons.image,
                      size: Constants.defaultIconRadius * 2,
                    ),
                SizedBox(
                  width: Constants.defaultPadding,
                ),
                Text('Choose image'),
              ],
            ),
          ),
        ));
  }

  DropdownMenuItem<String> dropdownButtonChooseImageWithoutGesture() {
    return DropdownMenuItem(
        value: 'Choose image',
        child: Padding(
          padding: EdgeInsets.only(bottom: Constants.defaultPadding),
          child: IntrinsicHeight(
            child: Row(
              children: <Widget>[
                chooseImageIcon ??
                    Icon(
                      Icons.image,
                      size: Constants.defaultIconRadius * 2,
                    ),
                SizedBox(
                  width: Constants.defaultPadding,
                ),
                Text('Choose image'),
              ],
            ),
          ),
        ));
  }

  Widget chooseIconImage(BuildContext context) {
    return FlatButton(
      onPressed: () async {
        Size size = MediaQuery.of(context).size;
        double rowHeight =
            Constants.defaultIconRadius * 2 + Constants.defaultPadding;
        double minHeightNeeded = Constants.defaultIcons.length * rowHeight +
            Constants.defaultPadding;

        showDialog(
            barrierDismissible: false,
            context: context,
            child: MyDialog(
              title: 'Pick an icon',
              content: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(top: Constants.defaultPadding),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: minHeightNeeded < size.height * 0.8
                        ? minHeightNeeded
                        : size.height * 0.8,
                    child: ListView.builder(
                        itemCount: Constants.defaultIcons.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: Constants.defaultPadding,
                                right: Constants.defaultPadding,
                                bottom: Constants.defaultPadding),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: Constants.defaultIconRadius,
                                  backgroundImage:
                                      Constants.defaultIcons[index].image,
                                  backgroundColor: Colors.transparent,
                                ),
                                SizedBox(
                                  width: Constants.defaultPadding,
                                ),
                                Text(Constants.defaultIconsNames[index])
                              ],
                            ),
                          );
                        })),
              ),
            ));

        // File file = await FilePicker.getFile(type: FileType.image);
        // changeIconImage(Image.asset(file.path,
        //     width: Constants.defaultIconRadius * 2,
        //     height: Constants.defaultIconRadius * 2));
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

  Widget chooseIconColor(BuildContext context) {
    return FlatButton(
      onPressed: () {
        showDialog(
            barrierDismissible: false,
            context: context,
            child: MyDialog(
              title: 'Pick a color',
              content: Container(
                margin: EdgeInsets.all(Constants.defaultPadding),
                width: MediaQuery.of(context).size.width * 0.8,
                child: BlockPicker(
                  availableColors: Constants.iconDefaultColors,
                  pickerColor: currentColor,
                  onColorChanged: changeIconColor,
                  // availableColors: , TODO wybrać kolory
                ),
              ),
            ));
      },
      color: Theme.of(context).accentColor,
      // shape: RoundedRectangleBorder(
      //     // borderRadius: BorderRadius.circular(20.0),
      //     // side: BorderSide(
      //     //   color: Theme.of(context).accentColor,
      //     //   width: 2.0,
      //     // ),
      //     ),
      // color: Theme.of(context).buttonColor,
      child: Container(
        child: Text(
          "Choose color",
        ),
      ),
    );
  }

  Widget bottomButtonsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Constants.defaultPadding),
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
                    log("DODANE", name: "LOL");
                    widget.addAccountCallback(accountData: accountData);
                    Navigator.of(context).pop();
                  } else {
                    log("NIE DODANE", name: "LOL");
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
