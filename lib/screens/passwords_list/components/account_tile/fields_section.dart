import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/field_widget.dart';
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
          (entry) => FieldWidget(
            label: entry.key,
            isPassword: entry.key.toLowerCase() == "password",
            value: entry.value,
          ),
        )
        .toList();

    return Column(children: mainInfos);
  }
}
