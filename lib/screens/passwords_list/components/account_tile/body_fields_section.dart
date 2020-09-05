import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/components/field_widget.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import '../../../../utils/constants.dart' as MyConstants;

class FieldsSection extends StatefulWidget {
  final bool showPassword;
  FieldsSection({
    Key key,
    @required this.accountData,
    this.showPassword = false,
  }) : super(key: key);

  final AccountData accountData;

  @override
  _FieldsSectionState createState() => _FieldsSectionState();
}

class _FieldsSectionState extends State<FieldsSection>
    with TickerProviderStateMixin {
  double _width;
  double _right;
  final Curve _curve = Curves.easeInOutBack;
  final Duration _duration = Duration(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    _width ??= MediaQuery.of(context).size.width -
        MyConstants.defaultIconRadius * 1.5 * 3 -
        MyConstants.defaultPadding * 2;
    _right ??= 0;

    var fieldsWidgetsMap = <String, Widget>{
      widget.accountData.email.name: EmailFieldWidget(
        readOnly: true,
        label: widget.accountData.email.name,
        value: widget.accountData.email.value,
        onChangedCallback: () {},
      ),
      widget.accountData.password.name: PasswordFieldWidget(
        readOnly: true,
        label: widget.accountData.password.name,
        value: widget.accountData.password.value,
        onChangedCallback: () {},
        showPassword: widget.showPassword,
      ),
    };

    widget.accountData.additionalFields.forEach(
        (element) => fieldsWidgetsMap[element.name] = AdditionalFieldWidget(
              label: element.name,
              readOnly: true,
              value: element.value,
              onChangedCallback: () {},
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
              children: [
                Expanded(
                  child: IntrinsicHeight(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        AnimatedContainer(
                            curve: _curve,
                            width: _width,
                            duration: _duration,
                            child: entry.value),
                        AnimatedPositioned(
                          curve: _curve,
                          right: _right,
                          duration: _duration,
                          child: ButtonBar(
                            buttonPadding: EdgeInsets.all(0.0),
                            children: [
                              IconButton(
                                padding: EdgeInsets.all(0.0),
                                constraints: BoxConstraints(
                                    minHeight:
                                        MyConstants.defaultIconRadius * 1.5,
                                    minWidth:
                                        MyConstants.defaultIconRadius * 1.5,
                                    maxHeight:
                                        MyConstants.defaultIconRadius * 1.5,
                                    maxWidth:
                                        MyConstants.defaultIconRadius * 1.5),
                                icon: Icon(
                                  Icons.arrow_circle_down,
                                  size: 36,
                                  color: Theme.of(context).accentColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _right = -3 * 36.0;
                                    _width = MediaQuery.of(context).size.width -
                                        MyConstants.defaultPadding * 2;
                                  });
                                },
                              ),
                              IconButton(
                                padding: EdgeInsets.all(0.0),
                                constraints: BoxConstraints(
                                    minHeight:
                                        MyConstants.defaultIconRadius * 1.5,
                                    minWidth:
                                        MyConstants.defaultIconRadius * 1.5,
                                    maxHeight:
                                        MyConstants.defaultIconRadius * 1.5,
                                    maxWidth:
                                        MyConstants.defaultIconRadius * 1.5),
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
                                    minHeight:
                                        MyConstants.defaultIconRadius * 1.5,
                                    minWidth:
                                        MyConstants.defaultIconRadius * 1.5,
                                    maxHeight:
                                        MyConstants.defaultIconRadius * 1.5,
                                    maxWidth:
                                        MyConstants.defaultIconRadius * 1.5),
                                icon: Icon(
                                  Icons.delete_forever_outlined,
                                  size: 36,
                                  color: MyConstants.pressedButtonColor,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
        .toList();

    return Column(
      children: [
        Column(children: mainInfos),
        Container(
          width: 100,
          height: 100,
          child: FlatButton(
              onPressed: () {
                setState(() {
                  _right = 0.0;
                  _width = MediaQuery.of(context).size.width -
                      36 * 3 -
                      MyConstants.defaultPadding * 2;
                });
              },
              color: Colors.red,
              child: Text("K")),
        )
      ],
    );
  }
}
