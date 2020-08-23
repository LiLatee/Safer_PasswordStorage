import 'package:flutter/material.dart';
import 'screens/passwords_list/passwords_list_page.dart';
import 'utils/themes.dart' as custom_themes;

void main() => runApp(MyApp());

//Future<void> main() async {
//  log("elo1", name: "LOL");
//  var key = MyEncryption().generateKey(length: 5);
//  var message = "Co tam słychać?";
//  log("elo2", name: "LOL");
//  var encrypted = await MyEncryption().encrypt(password: message, secretKey: key);
//  log("elo3", name: "LOL");
//  log(encrypted.toString(), name: "LOL");
//
//}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var test = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text(
              "Title",
            ),
            children: <Widget>[
              ExpansionTile(
                title: Text(
                  'Sub title',
                ),
                children: <Widget>[
                  ListTile(
                    title: Text('data'),
                  )
                ],
              ),
              ListTile(
                title: Text('data'),
              )
            ],
          ),
        ],
      ),
    );

    return MaterialApp(
      title: 'My Simple Password Storage',
      theme: custom_themes.darkTheme,
      home: PasswordsListPage(),
    );
  }
}
