import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/field_widget.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import '../../../../utils/constants.dart' as MyConstants;

class FieldsSection extends StatelessWidget {
  final bool showPassword;
  FieldsSection({
    Key key,
    @required this.accountData,
    this.showPassword = false,
  }) : super(key: key);

  final AccountData accountData;

  @override
  Widget build(BuildContext context) {
    var fieldsWidgetsMap = <String, Widget>{
      accountData.email.name: Expanded(
        child: EmailFieldWidget(
          readOnly: true,
          label: accountData.email.name,
          value: accountData.email.value,
          onChangedCallback: () {},
        ),
      ),
      accountData.password.name: Expanded(
        child: PasswordFieldWidget(
          readOnly: true,
          label: accountData.password.name,
          value: accountData.password.value,
          onChangedCallback: () {},
          showPassword: showPassword,
        ),
      ),
    };

    accountData.additionalFields
        .forEach((element) => fieldsWidgetsMap[element.name] = Expanded(
              child: AdditionalFieldWidget(
                label: element.name,
                readOnly: true,
                value: element.value,
                onChangedCallback: () {},
              ),
            ));

    List<Widget> mainInfos = fieldsWidgetsMap.entries
        .map(
          (entry) => Padding(
            padding: EdgeInsets.only(
              top: MyConstants.defaultPadding,
              left: MyConstants.defaultPadding,
              right: MyConstants.defaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                entry.value,
                // AnimatedContainer(
                //   // constraints: BoxConstraints(
                //   //   minWidth: MediaQuery.of(context).size.width -
                //   //       (MyConstants.defaultIconRadius * 1.5) * 3 -
                //   //       MyConstants.defaultPadding * 2,
                //   //   maxWidth: MediaQuery.of(context).size.width -
                //   //       (MyConstants.defaultIconRadius * 1.5) * 3 -
                //   //       MyConstants.defaultPadding * 2,
                //   // ),
                //   width: MediaQuery.of(context).size.width -
                //       36 * 3 -
                //       MyConstants.defaultPadding * 1,
                //   height: 50,
                //   color: Colors.yellow,
                //   duration: Duration(seconds: 1),
                // ),
                // AnimatedContainer(
                //   // constraints: BoxConstraints(
                //   //     minWidth: (MyConstants.defaultIconRadius * 1.5) * 3,
                //   //     maxWidth: (MyConstants.defaultIconRadius * 1.5) * 3),
                //   color: Colors.red,
                //   width: 36.0 * 3, // 3 icons
                //   height: 50,
                //   duration: Duration(seconds: 1),
                // ),
              ],
            ),
          ),
        )
        .toList();

    return Column(children: mainInfos);
  }
}
