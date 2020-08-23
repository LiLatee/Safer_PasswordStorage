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
            FlatButton(
                onPressed: () {},
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.remove_red_eye),
                        Text("Show")
                      ],
                    ),
                  ],
                )),
            FlatButton(
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(Icons.edit), Text("Edit")],
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Row(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.delete_forever),
                      Text("Remove")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
