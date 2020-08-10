import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';

class PasswordsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<PasswordsListPage> {
  @override
  Widget build(BuildContext context) {
    Widget getAccountTile({AccountData accountData}) {
      var icon = const AssetImage('images/facebook.png');

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
                    Text(
                      "${accountData.nick}",
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${accountData.login}",
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${accountData.password}",
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
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

        Widget additionalInfo = Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Additionial Information:",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(
                      "${accountData.additionalInfo}",
                      overflow: TextOverflow.clip,
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
        return Column(
          children: <Widget>[
            loginAndPassword,
            buttons,
            accountData.additionalInfo != null ? additionalInfo : Container(),
          ],
        );
      }

      return Card(
          child: ExpansionTile(
            leading: CircleAvatar(
              backgroundImage: icon,
              backgroundColor: Colors.transparent,
            ),
            title: Text("${accountData.accountName}"),
            children: <Widget>[
              getExpandedPart(),
            ],
          ),
          color: Theme.of(context).primaryColor);
    }

    var testAccounts = [
      AccountData(
          accountName: "Facebook",
          nick: "LiLatee",
          login: "me.myself.and.i@gmail.com",
          password: "sdnfuimejbgdn39032fnw v",
          additionalInfo: "I love my parents."),
      AccountData(
          accountName: "Twitter",
          nick: "Kadanna",
          login: "we.have_a_city_to_burn@gmail.com",
          password: "sdnfuimejbgdn39032fnw v"),
      AccountData(
        accountName: "Facebook",
        nick: "CookieMonster123",
        login: "where_are_my_cookies?@gmail.com",
        password: "sdnfuimejbgdn39032fnw v",
        additionalInfo: " Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?  Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie? "
            "Hej. Co tam słychać? U mnie w porządku. A co u Ciebie?",
      ),
    ];

    // Testing list of accounts.
    return ListView.builder(
      itemCount: testAccounts.length,
      itemBuilder: (var context, var index) =>
          getAccountTile(accountData: testAccounts[index]),
    );
  }
}
