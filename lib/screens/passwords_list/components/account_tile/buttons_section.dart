import 'package:flutter/material.dart';

class ButtonsSection extends StatelessWidget {
  const ButtonsSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonBar(
          children: <Widget>[
            buildFlatButton(
                context: context,
                onPressed: () {},
                icon: Icon(Icons.remove_red_eye),
                name: 'Show'),
            buildFlatButton(
                context: context,
                onPressed: () {},
                icon: Icon(Icons.edit),
                name: 'Edit'),
            buildFlatButton(
                context: context,
                onPressed: () {},
                icon: Icon(Icons.delete_forever),
                name: 'Remove'),
            buildFlatButton(
                context: context,
                onPressed: () {},
                icon: Icon(Icons.add),
                name: 'Add field'),
          ],
        ),
      ],
    );
  }

  FlatButton buildFlatButton(
      {BuildContext context, Function onPressed, Icon icon, String name}) {
    return FlatButton(
      textColor: Theme.of(context).accentColor,
      onPressed: onPressed,
      child: Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[icon, Text(name)],
          ),
        ],
      ),
    );
  }
}
