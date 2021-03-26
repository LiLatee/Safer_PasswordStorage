import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:mysimplepasswordstorage/models/field_data_entity.dart';
import 'package:provider/provider.dart';

import 'package:mysimplepasswordstorage/utils/AppConstants.dart' as MyConstants;
import 'section_buttons.dart';
import 'section_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IsFieldChanged with ChangeNotifier {
  bool _isFieldChanged;

  IsFieldChanged(this._isFieldChanged);

  bool get isFieldChanged => _isFieldChanged;

  set isFieldChanged(bool value) {
    _isFieldChanged = value;
    notifyListeners();
  }
}
class AccountDataExpandedPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountDataEntity accountDataEntity =
        Provider.of<AccountDataEntity>(context);
    var nOfFields = accountDataEntity.fields.length;
    var height = nOfFields * MyConstants.heightForOneField >
            MyConstants.maxHeightForFields
        ? MyConstants.maxHeightForFields
        : nOfFields * MyConstants.heightForOneField;

    return MultiProvider(
      providers: [
        Provider<Map<String, FieldDataEntity>>(create: (context) => {}),
        ChangeNotifierProvider<IsFieldChanged>(create: (context) => IsFieldChanged(false)),
      ],
      child: Column(
        children: [
          Container(height: height, child: SectionFields()),
          SectionButtons(),
        ],
      ),
    );
  }
}

// class AccountDataExpandedPart extends StatefulWidget {
//
//   AccountDataExpandedPart({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   _AccountDataExpandedPartState createState() =>
//       _AccountDataExpandedPartState();
// }
//
// class _AccountDataExpandedPartState extends State<AccountDataExpandedPart> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       shrinkWrap: true,
//       children: <Widget>[
//         // FieldsSection(),
//         // ButtonsSection(),
//       ],
//     );
//   }
// }
