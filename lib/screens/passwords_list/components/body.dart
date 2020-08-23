import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../models/account_data.dart';

import 'passwords_list.dart';

class Body extends StatelessWidget {
  var testAccounts = [
    AccountData(
        accountName: "Facebook2",
        nick: "LiLatee",
        login: "me.myself.and.i@gmail.com",
        password: "sdnfuimejbgdn39032fnw v",
        additionalInfo: "I love my parents."),
    AccountData(
        accountName: "Twitter",
        nick: "Kadanna",
        login: "we.have_a_city_to_burn@gmail.com",
        password: "sdnfuimejbgdn39032fnw v"),
    AccountData(
      accountName: "Facebook",
      nick: "CookieMonster123",
      login: "where_are_my_cookiesLOOOOOOLLLL?@gmail.com",
      password: "sdnfuimejbgdn39032fnw v",
      additionalInfo: "Hej. Co tam słychać? U mnie w porządku. "
          "A co u Ciebie?  Hej. Co tam słychać? U mnie w porządku. "
          "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
          "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
          "A co u Ciebie?Hej. Co tam słychać? U mnie w porządku. "
          "A co u Ciebie? "
          "Hej. Co tam słychać? U mnie w porządku. A co u Ciebie?",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PasswordsList(testAccounts: testAccounts);
  }
}
