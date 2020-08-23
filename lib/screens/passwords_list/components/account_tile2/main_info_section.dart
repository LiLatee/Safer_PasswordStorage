import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';

class MainInfoSection extends StatelessWidget {
  const MainInfoSection({
    Key key,
    @required this.accountData,
  }) : super(key: key);

  final AccountData accountData;

  @override
  Widget build(BuildContext context) {
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
              initialValue: entry.key == "Password" ? "Password" : entry.value,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        )
        .toList();

    return IntrinsicHeight(
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
      ),
    );
  }
}
