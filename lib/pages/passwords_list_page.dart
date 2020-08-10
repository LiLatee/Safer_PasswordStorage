import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: public_member_api_docs
class PasswordsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<PasswordsListPage> {
  @override
  Widget build(BuildContext context) {
    Widget getAccountTile(
        {String accountName,
        String nick,
        String loginEmail,
        String password,
        AssetImage icon = const AssetImage('images/facebook.png')}) {
      Widget getExpandedPart() {
        Widget loginAndPassword = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DefaultTextStyle(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text("Nick: "),
                  SizedBox(height: 10),
                  Text("Login/Email: "),
                  SizedBox(height: 10),
                  Text("Password: "),
                ],
              ),
            ),
            DefaultTextStyle(
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("$nick", overflow: TextOverflow.clip,),
                    SizedBox(height: 10),
                    Text("$loginEmail", softWrap: true, ),
                    SizedBox(height: 10),
                    Text("$password", overflow: TextOverflow.clip,),
                  ],
                ),
              ),
            ),
          ],
        );

        Widget buttons = Row(
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

        return Column(
          children: <Widget>[
            loginAndPassword,
            buttons,
          ],
        );
      }

      return Card(
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundImage: icon,
              backgroundColor: Colors.transparent,),
            title: Text("$accountName"),
            children: <Widget>[
              getExpandedPart(),
            ],
          ),
          color: Theme.of(context).primaryColor);
    }

    return ListView(
      children: <Widget>[
        getAccountTile(
            accountName: "Facebook",
            nick: "LiLatee",
            loginEmail: "marcin.hradowicz@gmail.com",
            password: "**********",
            icon: AssetImage('images/facebook.png')),
        getAccountTile(
            accountName: "Twitter",
            nick: "LiLatee",
            loginEmail: "marcin.hradow333333333333333icz222@gmail.com",
            password: "**********"),
        getAccountTile(
            accountName: "Twitter",
            nick: "LiLatee",
            loginEmail: "marcin.hradowicz@gmail.com",
            password: "**********",
            icon: AssetImage('images/twitter.png'))
      ],
    );
  }
}
