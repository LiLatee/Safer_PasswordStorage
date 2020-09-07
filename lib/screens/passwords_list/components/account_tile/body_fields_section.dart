import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../components/field_widget.dart';
import '../../../../models/account_data.dart';
import '../../../../utils/constants.dart' as MyConstants;

class FieldsSection extends StatefulWidget {
  final bool showPassword;
  FieldsSection({
    Key key,
    this.showPassword = false,
  }) : super(key: key);

  @override
  _FieldsSectionState createState() => _FieldsSectionState();
}

class _FieldsSectionState extends State<FieldsSection>
    with TickerProviderStateMixin {
  List<Widget> fieldsWidgets = [];
  AccountData accountData;
  int counter = 0; // TODO do usunięcia

  Widget buildItem(BuildContext context, Widget item, Animation animation,
      {int itemIndex}) {
    // return FadeTransition(
    //   opacity: animation,
    //   child: item,
    // );

    // return SlideTransition(
    //   position: Tween<Offset>(end: Offset.zero, begin: Offset(-1.0, 0)).animate(
    //       CurvedAnimation(
    //           parent: animation,
    //           curve: Curves.easeInOutBack,
    //           reverseCurve: Curves.easeInOutBack)),
    //   child: item,
    // );

    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOutBack,
          reverseCurve: Curves.easeInOutBack),
      child: item,
    );
  }

  @override
  Widget build(BuildContext context) {
    accountData = Provider.of<AccountData>(context);
    buildFieldsWidgets(context);

    // return Container(
    //   constraints: BoxConstraints.loose(Size(double.infinity, 300)),
    //   child: AnimatedList(
    //     shrinkWrap: true,
    //     key: _listKey,
    //     initialItemCount: items.length,
    //     itemBuilder: (context, index, animation) =>
    //         buildItem(context, items[index], animation),
    //   ),
    // );
    return Container(
      constraints: BoxConstraints.loose(Size(double.infinity, 300)),
      child: AnimatedList(
        shrinkWrap: true,
        key: Provider.of<AccountData>(context).listKey,
        initialItemCount: fieldsWidgets.length,
        itemBuilder: (context, index, animation) =>
            buildItem(context, fieldsWidgets[index], animation),
      ),
    );
  }

  void buildFieldsWidgets(BuildContext context) {
    var fieldsWidgetsList = <Widget>[
      EmailFieldWidget(
        readOnly: true,
        label: accountData.email.name,
        value: accountData.email.value,
        onChangedCallback: () {},
      ),
      PasswordFieldWidget(
        readOnly: true,
        label: accountData.password.name,
        value: accountData.password.value,
        onChangedCallback: () {},
        showPassword: Provider.of<AccountData>(context).isShowButtonPressed,
      ),
    ];

    accountData.additionalFields.forEach((element) {
      fieldsWidgetsList.add(
        AdditionalFieldWidget(
          label: element.name,
          readOnly: true,
          value: element.value,
          onChangedCallback: () {},
        ),
      );
    });

    fieldsWidgets = fieldsWidgetsList
        .asMap()
        .entries
        .map(
          (e) => FieldRowWithButtons(
            index: e.key,
            fieldWidget: e.value,
            buildItem: buildItem,
          ),
        )
        .toList();

    ;
  }
}

class FieldRowWithButtons extends StatelessWidget {
  FieldRowWithButtons({
    Key key,
    @required this.index,
    @required this.fieldWidget,
    @required this.buildItem,
  }) : super(key: key);

  final int index;
  final Widget fieldWidget;

  final Duration _duration = MyConstants.animationsDuration * 2;
  double _width;
  double _right;
  final Function buildItem;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _width ??= size.width;
    _right ??= -3 * MyConstants.defaultIconRadius * 1.5;
    AccountData accountData = Provider.of<AccountData>(context);

    Curve curve = Curves.easeInOutBack;

    if (!accountData.isEditButtonPressed) {
      // curve = Curves.easeInBack;
      _right = -3 * MyConstants.defaultIconRadius * 1.5;
      _width = size.width;
    } else if (accountData.isEditButtonPressed) {
      // curve = Curves.easeOutBack;
      _right = 0;
      _width = size.width -
          MyConstants.defaultIconRadius * 1.5 * 3 -
          MyConstants.defaultPadding * 2;
    }

    return Container(
      padding: EdgeInsets.only(
        top: MyConstants.defaultPadding,
        left: MyConstants.defaultPadding,
        right: MyConstants.defaultPadding,
      ),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                AnimatedPositioned(
                  curve: curve,
                  right: _right,
                  duration: _duration,
                  child: ButtonBar(
                    buttonPadding: EdgeInsets.all(0.0),
                    children: [
                      buildIconButton(
                          context: context,
                          iconData: Icons.arrow_circle_up,
                          onPressed: () {}),
                      buildIconButton(
                          context: context,
                          iconData: Icons.arrow_circle_down,
                          onPressed: () {}),
                      buildIconButton(
                          context: context,
                          iconData: Icons.delete_forever_outlined,
                          color: MyConstants.pressedButtonColor,
                          onPressed: () {
                            var itemToRemove = this;
                            accountData.listKey.currentState.removeItem(
                                index,
                                (context, animation) => buildItem(
                                    context, itemToRemove, animation,
                                    itemIndex: index),
                                duration: MyConstants.animationsDuration);

                            accountData.removeFieldAt(index - 2);
                          }),
                    ],
                  ),
                ),
                AnimatedContainer(
                  margin: EdgeInsets.only(
                      top:
                          5.0), // without that labels in TextFormField are cut, idk why
                  curve: curve,
                  width: _width,
                  duration: _duration,
                  child: fieldWidget,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  IconButton buildIconButton(
      {@required BuildContext context,
      @required IconData iconData,
      @required Function onPressed,
      Color color}) {
    color ??= Theme.of(context).accentColor;
    return IconButton(
      padding: EdgeInsets.all(0.0),
      constraints: BoxConstraints(
          minHeight: MyConstants.defaultIconRadius * 1.5,
          minWidth: MyConstants.defaultIconRadius * 1.5,
          maxHeight: MyConstants.defaultIconRadius * 1.5,
          maxWidth: MyConstants.defaultIconRadius * 1.5),
      icon: Icon(
        iconData,
        size: MyConstants.defaultIconRadius * 1.5,
        color: color,
      ),
      onPressed: onPressed,
    );
  }
}
