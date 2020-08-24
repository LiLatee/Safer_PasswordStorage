import 'dart:developer';

import 'package:rxdart/rxdart.dart';

import 'package:mysimplepasswordstorage/models/account_data.dart';

class AllAccountsBloc {
  List<AccountData> accounts = [];
  BehaviorSubject<List<AccountData>> _behaviorSubject;

  AllAccountsBloc({
    accounts,
  }) {
    this.accounts = accounts;
    _behaviorSubject = BehaviorSubject.seeded(this.accounts);
  }

  Stream<List<AccountData>> get accountsObservable => _behaviorSubject.stream;

  void addAccount({accountData: AccountData}) {
    accounts.add(AccountData(
        accountName: "Eluwa",
        email: Field(name: "Email", value: "sdfsdf@gmail.com"),
        password: Field(name: "Password", value: "haselko")));
    _behaviorSubject.sink.add(accounts);
  }
}
