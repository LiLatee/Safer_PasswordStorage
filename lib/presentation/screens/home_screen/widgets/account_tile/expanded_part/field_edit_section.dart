import 'package:flutter/material.dart';

import '../../../../../../core/constants/AppConstants.dart';

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
          //   color: AppConstants.pressedButtonColor,
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
  //       duration: AppConstants.animationsDuration);
  //
  //   accountData.removeFieldAt(index);
  // }

  IconButton buildIconButton(
      {required BuildContext context,
      required IconData iconData,
      required Function() onPressed,
      Color? color}) {
    // color ??= Theme.of(context).accentColor;
    return IconButton(
      padding: EdgeInsets.all(0.0),
      constraints: BoxConstraints(
          minHeight: AppConstants.defaultIconRadius * 1.5,
          minWidth: AppConstants.defaultIconRadius * 1.5,
          maxHeight: AppConstants.defaultIconRadius * 1.5,
          maxWidth: AppConstants.defaultIconRadius * 1.5),
      icon: Icon(
        iconData,
        size: AppConstants.defaultIconRadius * 1.5,
        // color: color,
      ),
      onPressed: onPressed,
    );
  }
}
