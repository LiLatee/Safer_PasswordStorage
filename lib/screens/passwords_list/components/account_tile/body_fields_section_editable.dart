import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/field_widget.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import '../../../../utils/constants.dart' as MyConstants;

class FieldsSectionEditable extends StatelessWidget {
  final bool showPassword;
  FieldsSectionEditable({
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
          readOnly: false,
          label: accountData.email.name,
          value: accountData.email.value,
          onChangedCallback: () {},
        ),
      ),
      accountData.password.name: Expanded(
        child: PasswordFieldWidget(
          readOnly: false,
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
                readOnly: false,
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
              // right: MyConstants.defaultPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                entry.value,
                ButtonBar(
                  buttonPadding: EdgeInsets.all(0.0),
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      constraints: BoxConstraints(
                          minHeight: 36,
                          minWidth: 36,
                          maxHeight: 36,
                          maxWidth: 36),
                      icon: Icon(
                        Icons.arrow_circle_down,
                        size: 36,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      constraints: BoxConstraints(
                          minHeight: 36,
                          minWidth: 36,
                          maxHeight: 36,
                          maxWidth: 36),
                      icon: Icon(
                        Icons.arrow_circle_up,
                        size: 36,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0.0),
                      constraints: BoxConstraints(
                          minHeight: 36,
                          minWidth: 36,
                          maxHeight: 36,
                          maxWidth: 36),
                      icon: Icon(
                        Icons.delete_forever_outlined,
                        size: 36,
                        color: MyConstants.pressedButtonColor,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
        .toList();

    return Column(children: mainInfos);
  }
}
