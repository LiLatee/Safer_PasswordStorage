import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';

class PasswordsListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordListPageState();
}

class _PasswordListPageState extends State<PasswordsListPage> {
  void createNewRecord() {}

  @override
  Widget build(BuildContext context) {
    Widget getAccountTile({AccountData accountData}) {
      var icon = const AssetImage('images/facebook.png');

      Widget getExpandedPart() {

        var dataValueMap = <String, String>{
          "Nick": accountData.nick,
          "Login": accountData.login,
          "Password": accountData.password,
        };

        List<Widget> mainInfoTitles = dataValueMap.entries
            .map((entry) => Text(
                  '${entry.key}:\t',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.subtitle2,
                ))
            .toList();

        List<Widget> mainInfoValues = dataValueMap.entries
            .map(
              (entry) => Expanded(
                child: TextFormField(
                  readOnly: true,
                  obscureText: entry.key == "Password" ? true : false,
                  textAlign: TextAlign.start,
                  initialValue:
                      entry.key == "Password" ? "Password" : entry.value,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            )
            .toList();

        Widget mainInfoSection = IntrinsicHeight(
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: mainInfoTitles,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: mainInfoValues,
                ),
              ),
            ],
          ),);

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
            mainInfoSection,
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
        login: "where_are_my_cookiesLOOOOOOLLLL?@gmail.com",
        password: "sdnfuimejbgdn39032fnw v",
        additionalInfo: "Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?  Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
            "A co u Ciebie? "
            "Hej. Co tam słychać? U mnie w porządku. A co u Ciebie?",
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("My Simple Password Storage"),
      ),
      body: ListView.builder(
        itemCount: testAccounts.length,
        itemBuilder: (var context, var index) =>
            getAccountTile(accountData: testAccounts[index]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
      ),
    );
  }
}
