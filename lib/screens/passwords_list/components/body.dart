import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/account_data.dart';

import 'passwords_list.dart';

class Body extends StatelessWidget {
  var testAccounts;

  Body({@required this.testAccounts});

  @override
  Widget build(BuildContext context) {
    return PasswordsList(testAccounts: testAccounts);
  }
}
