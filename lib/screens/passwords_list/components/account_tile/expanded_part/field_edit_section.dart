import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/AppConstants.dart' as MyConstants;

class FieldEditSection extends StatelessWidget {
  const FieldEditSection({
    Key? key,
    required this.curve,
    required double right,
    required Duration duration,
    required this.index,
    // required this.buildItem,
  })  : _right = right,
        _duration = duration,
        super(key: key);

  final Curve curve;
  final double _right;
  final Duration _duration;
  final int index;
  // final Function buildItem;

  @override
  Widget build(BuildContext context) {
    // AccountData accountData = Provider.of<AccountData>(context);

    return AnimatedPositioned(
      curve: curve,
      right: _right,
      duration: _duration,
      child: ButtonBar(
        buttonPadding: const EdgeInsets.all(0.0),
        children: [
          // buildIconButton(
          //   context: context,
          //   iconData: Icons.delete_forever_outlined,
          //   color: MyConstants.pressedButtonColor,
          //   onPressed: () => onPressedRemove(accountData),
          // ),
          buildIconButton(
            context: context,
            iconData: Icons.reorder,
            onPressed: () {},
          ),

        ],
      ),
    );
  }

  // void onPressedRemove(AccountData accountData) {
  //   var itemToRemove = this;
  //   accountData.listKey.currentState.removeItem(
  //       index,
  //       (context, animation) =>
  //           buildItem(context, itemToRemove, animation, itemIndex: index),
  //       duration: MyConstants.animationsDuration);
  //
  //   accountData.removeFieldAt(index);
  // }

  IconButton buildIconButton(
      {required BuildContext context,
      required IconData iconData,
      required Function() onPressed,
      Color? color}) {
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
