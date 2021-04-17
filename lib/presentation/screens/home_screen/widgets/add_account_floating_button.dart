import 'package:flutter/material.dart';

import 'add_account_dialog/add_account_dialog.dart';

class AddAccountFloatingButton extends StatelessWidget {
  @override
  Widget build(BuildContext superContext) {
    Size size = MediaQuery.of(superContext).size;

    return FloatingActionButton(
      onPressed: () {
        // log(SQLprovider.TEMP_DB.database.toString());
        // Provider.of<DataProvider>(context, listen: false)
        //     .addAccount(AccountDataEntity(accountName: "Dodane"));
        showGeneralDialog(
          barrierColor: Colors.black.withOpacity(0.5),
          // transitionBuilder: (context, a1, a2, widget) {
          // return Transform.scale(
          //   origin: Offset(size.width / 2,
          //       size.height / 2), // TODO jak wziąć pozycje przycisku
          //   scale: a1.value,
          //   child: Opacity(
          //     opacity: a1.value,
          //     child: AddAccountDialog(superContext: superContext),/// context required by Provider in the subtree
          //   ),
          // );
          // },
          transitionDuration: Duration(milliseconds: 200),
          barrierDismissible: false,
          barrierLabel: '',
          context: superContext,
          pageBuilder: (context, animation1, animation2) =>
              AddAccountDialog(superContext: superContext),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
