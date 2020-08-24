import 'package:rxdart/rxdart.dart';

import 'package:mysimplepasswordstorage/models/account_data.dart';

class AccountBloc {
  AccountData accountData;
  BehaviorSubject<AccountData> _behaviorSubject;

  AccountBloc({
    this.accountData,
  });

  Stream<AccountData> get accountDataObservable => _behaviorSubject.stream;
}
