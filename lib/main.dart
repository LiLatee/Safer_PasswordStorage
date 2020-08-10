import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/pages/passwords_list_page.dart';

import 'package:mysimplepasswordstorage/utils/themes.dart' as custom_themes;
void main() => runApp(MyApp());

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
                title: Text(
                    'data'
                ),
              )
            ],
          ),
        ],
      ),
    );

    return MaterialApp(
      title: 'My Simple Password Storage',
      theme: custom_themes.darkTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Simple Password Storage"),),
        body: PasswordsListPage(),
      ),
    );
  }
}


