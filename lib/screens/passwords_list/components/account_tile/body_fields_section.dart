import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/BLoCs/account_expanded_part_bloc.dart';
import 'package:mysimplepasswordstorage/components/field_widget.dart';
import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:mysimplepasswordstorage/utils/constants.dart';
import 'package:provider/provider.dart';
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
  @override
  Widget build(BuildContext context) {
    var fieldsWidgetsMap = <String, Widget>{
      widget.accountData.email.name: EmailFieldWidget(
        readOnly: true,
        label: widget.accountData.email.name,
        value: widget.accountData.email.value,
        onChangedCallback: () {},
      ),
      widget.accountData.password.name: StreamBuilder(
        stream: Provider.of<ExpandedPartBloc>(context).showButtonStream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          return PasswordFieldWidget(
            readOnly: true,
            label: widget.accountData.password.name,
            value: widget.accountData.password.value,
            onChangedCallback: () {},
            showPassword: snapshot.data ?? false,
          );
        },
      )
    };

    widget.accountData.additionalFields.forEach(
        (element) => fieldsWidgetsMap[element.name] = AdditionalFieldWidget(
              label: element.name,
              readOnly: true,
              value: element.value,
              onChangedCallback: () {},
            ));

    List<Widget> mainInfos = fieldsWidgetsMap.entries
        .map((entry) => FieldRowWithButtons(fieldWidget: entry.value))
        .toList();

    return Column(
      children: [
        Column(children: mainInfos),
        // Container(
        //   width: 100,
        //   height: 100,
        //   child: FlatButton(
        //       onPressed: () {
        //         setState(() {
        //           _right = 0.0;
        //           _width = size.width -
        //               MyConstants.defaultIconRadius * 1.5 * 3 -
        //               MyConstants.defaultPadding * 2;
        //         });
        //       },
        //       color: Colors.red,
        //       child: Text("K")),
        // )
      ],
    );
  }
}

class FieldRowWithButtons extends StatelessWidget {
  FieldRowWithButtons({
    Key key,
    @required this.fieldWidget,
  }) : super(key: key);

  final Widget fieldWidget;

  final Duration _duration = MyConstants.animationsDuration * 2;
  double _width;
  double _right;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _width ??= size.width;
    _right ??= -3 * MyConstants.defaultIconRadius * 1.5;
    return StreamBuilder<ButtonState>(
        stream: Provider.of<ExpandedPartBloc>(context).editButtonStream,
        builder: (context, AsyncSnapshot<ButtonState> snapshot) {
          Curve curve = Curves.easeInOutBack;

          if (snapshot.data == ButtonState.unpressed) {
            curve = Curves.easeInBack;
            _right = -3 * MyConstants.defaultIconRadius * 1.5;
            _width = size.width;
          } else if (snapshot.data == ButtonState.pressed) {
            curve = Curves.easeOutBack;
            _right = 0;
            _width = size.width -
                MyConstants.defaultIconRadius * 1.5 * 3 -
                MyConstants.defaultPadding * 2;
          }

          return Container(
            padding: EdgeInsets.only(
              top: MyConstants.defaultPadding,
              left: MyConstants.defaultPadding,
              right: MyConstants.defaultPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      AnimatedPositioned(
                        curve: curve,
                        right: _right,
                        duration: _duration,
                        child: ButtonBar(
                          buttonPadding: EdgeInsets.all(0.0),
                          children: [
                            buildIconButton(
                                context: context,
                                iconData: Icons.arrow_circle_up,
                                onPressed: () {}),
                            buildIconButton(
                                context: context,
                                iconData: Icons.arrow_circle_down,
                                onPressed: () {}),
                            buildIconButton(
                                context: context,
                                iconData: Icons.delete_forever_outlined,
                                color: MyConstants.pressedButtonColor,
                                onPressed: () {}),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        margin: EdgeInsets.only(
                            top:
                                5.0), // without that labels in TextFormField are cut, idk why
                        curve: curve,
                        width: _width,
                        duration: _duration,
                        child: fieldWidget,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }

  IconButton buildIconButton(
      {@required BuildContext context,
      @required IconData iconData,
      @required Function onPressed,
      Color color}) {
    color ??= Theme.of(context).accentColor;
    return IconButton(
      padding: EdgeInsets.all(0.0),
      constraints: BoxConstraints(
          minHeight: MyConstants.defaultIconRadius * 1.5,
          minWidth: MyConstants.defaultIconRadius * 1.5,
          maxHeight: MyConstants.defaultIconRadius * 1.5,
          maxWidth: MyConstants.defaultIconRadius * 1.5),
      icon: Icon(
        iconData,
        size: MyConstants.defaultIconRadius * 1.5,
        color: color,
      ),
      onPressed: onPressed,
    );
  }
}
