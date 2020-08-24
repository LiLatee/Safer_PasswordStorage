import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/constants.dart' as constants;
import 'package:mysimplepasswordstorage/models/account_data.dart';

class FieldsSection extends StatelessWidget {
  const FieldsSection({
    Key key,
    @required this.accountData,
  }) : super(key: key);

  final AccountData accountData;

  @override
  Widget build(BuildContext context) {
    var dataValueMap = <String, String>{
      "Email": accountData.email.value,
      "Password": accountData.password.value,
    };

    accountData.additionalFields
        .forEach((element) => dataValueMap[element.name] = element.value);

    List<Widget> mainInfos = dataValueMap.entries
        .map(
          (entry) => Container(
            padding: EdgeInsets.only(
                top: constants.defaultPadding / 2,
                left: constants.defaultPadding / 2,
                right: constants.defaultPadding / 2),
            child: TextFormField(
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor)),
                  border: OutlineInputBorder(),
                  labelText: entry.key,
                  labelStyle: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontWeight: FontWeight.bold)),
              readOnly: false,
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines:
                  (entry.key == "Password") || (entry.key == "Email") ? 1 : 5,
              obscureText: entry.key == "Password" ? true : false,
              initialValue: entry.key == "Password" ? "Password" : entry.value,
            ),
          ),
        )
        .toList();

    return Column(children: mainInfos);
  }
}
