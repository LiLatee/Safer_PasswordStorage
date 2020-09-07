import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../BLoCs/account_expanded_part_bloc.dart';
import '../../../../models/account_data.dart';
import 'body_buttons_section.dart';
import 'body_fields_section.dart';

class AccountDataExpandedPart extends StatefulWidget {
  final AccountData accountData;

  AccountDataExpandedPart({
    Key key,
    @required this.accountData,
  }) : super(key: key);

  @override
  _AccountDataExpandedPartState createState() =>
      _AccountDataExpandedPartState();
}

class _AccountDataExpandedPartState extends State<AccountDataExpandedPart> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ExpandedPartBloc()),
        ChangeNotifierProvider.value(value: widget.accountData),
      ],
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          FieldsSection(),
          ButtonsSection(),
        ],
      ),
    );
  }
}
