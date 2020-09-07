import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/account_data.dart';
import '../../../../utils/constants.dart' as MyConstants;

class ButtonsSection extends StatelessWidget {
  ButtonsSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.all(MyConstants.defaultPadding),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  MyConstants.defaultCircularBorderRadius),
              color: Theme.of(context).secondaryHeaderColor,
            ), // TODO
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                buildShowButton(context),
                buildEditButton(context),
                AccountDataTileButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete_forever),
                    label: 'Remove'),
                buildAddFieldButton(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  AccountDataTileButton buildAddFieldButton(BuildContext context) {
    return AccountDataTileButton(
        onPressed: () {
          AccountData account =
              Provider.of<AccountData>(context, listen: false);

          if (!account.isEditButtonPressed) {
            account.pressEditButton();
          }

          account.addField(name: "Siemanko", value: "taka se wartość");

          account.listKey.currentState.insertItem(account.getNumberOfFields - 1,
              duration: MyConstants.animationsDuration);
        },
        icon: Icon(Icons.add),
        label: 'Add field');
  }

  Widget buildEditButton(BuildContext context) {
    AccountData accountData = Provider.of<AccountData>(context);
    return AccountDataTileButton(
      onPressed: () {
        accountData.pressEditButton();
      },
      icon: Icon(Icons.edit),
      label: 'Edit',
      pressedButtonColor: accountData.isEditButtonPressed
          ? MyConstants.pressedButtonColor
          : Colors.transparent,
      canBePressed: true,
    );
  }

  Widget buildShowButton(BuildContext context) {
    AccountData accountData = Provider.of<AccountData>(context);
    return AccountDataTileButton(
      onPressed: () {
        accountData.pressShowButton();
      },
      icon: Icon(Icons.remove_red_eye),
      label: 'Show',
      pressedButtonColor: accountData.isShowButtonPressed
          ? MyConstants.pressedButtonColor
          : Colors.transparent,
      canBePressed: true,
    );
  }
}

class AccountDataTileButton extends StatefulWidget {
  final Function onPressed;
  final Icon icon;
  final String label;
  Color pressedButtonColor;
  final bool canBePressed;
  AccountDataTileButton({
    Key key,
    @required this.onPressed,
    @required this.icon,
    @required this.label,
    this.pressedButtonColor = Colors.transparent,
    this.canBePressed = false,
  }) : super(key: key);

  @override
  _AccountDataTileButtonState createState() => _AccountDataTileButtonState();
}

class _AccountDataTileButtonState extends State<AccountDataTileButton> {
  Color textColor;

  @override
  Widget build(BuildContext context) {
    textColor ??= Theme.of(context).accentColor;
    widget.pressedButtonColor ??= Theme.of(context).primaryColor;
    return AnimatedContainer(
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(MyConstants.defaultCircularBorderRadius),
        color: widget.pressedButtonColor,
      ),
      duration: MyConstants.animationsDuration,
      child: FlatButton(
        textColor: textColor,
        onPressed: () {
          widget.onPressed();
        },
        child: Row(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[widget.icon, Text(widget.label)],
            ),
          ],
        ),
      ),
    );
  }
}
