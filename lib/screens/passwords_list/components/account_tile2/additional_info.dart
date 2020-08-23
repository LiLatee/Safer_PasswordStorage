import 'package:flutter/material.dart';
import '../../../../models/account_data.dart';

class AdditionalInfo extends StatelessWidget {
  const AdditionalInfo({
    Key key,
    @required this.accountData,
  }) : super(key: key);

  final AccountData accountData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              "Additionial Information:",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Text(
                  "${accountData.additionalInfo}",
                  overflow: TextOverflow.clip,
                  softWrap: true,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
