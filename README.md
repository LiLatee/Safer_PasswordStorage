# Safer
## [Changelog](./CHANGELOG.md) <-- Available apks to download

[YouTube Video](https://www.youtube.com/watch?v=nzW00jSm-D8&list=PLngjrGkIotwzGb2arctKFKAfTSqlDCeoV&index=1&t=1s)
## Polski (PL)
***Safer*** pozwala w przejrzysty sposób zapisywać wszystkie istotne informacje dotyczące Twoich kont w internecie i nie tylko. 
Nie korzysta z połączenia z internetem, wszystkie dane zapisywanie są bezpośrednio na Twoim urządzeniu, więc nie musisz bać się o ich wyciek. 

***Safer*** pozwala na eksportowanie zapisanych danych w przypadku zmiany urządzenia na nowe. Może to także służyć jako ręczny mechanizm tworzenia kopii zapasowej. 

***Safer*** jest aplikacją hobbistyczną, która w przyszłości będzie dalej się rozwijać.

**UWAGA**: Wszystkie zapisywane dane na urządzeniu są szyfrowane. Podobnie podczas eksportowania danych. Jednak wciąż nie zalecamy przetrzymywania w aplikacji bardzo ważnych informacji takich jak dane logowania do konta bankowego.

**Funkcjonalności/Narzędzia**:
- architektura w większości wykorzystująca wzorzec projektowy **BLOC** (oparta na cubitach);
- zmiana motywu jasny/ciemny/systemowy;
- zmiana języka polski/angielski/systemowy;
- szyfrowanie eksportowanego pliku z danymi z użyciem bibliotkei [aes_crypt](https://pub.dev/packages/aes_crypt) - jedyna wykorzystana biblioteka nie spełniająca *null-safety*;
- wykorzystanie biblioteki [floor](https://pub.dev/packages/floor) do zarządzania lokalną bazą danych **SQLite**;
- szyfrowanie danych w bazie za pomocą [encrypt](https://pub.dev/packages/encrypt);
- logowanie z użyciem kodu PIN, a także możliwość włączenia logowania z użyciem biometrii [local_auth](https://pub.dev/packages/local_auth);
- automatyczne wylogowanie z aplikacji po 1 minucie przebywania jako aplikacja w tle;
- *dependency injection* za pomocą biblioteki [get_it](https://pub.dev/packages/get_it).


## English (EN)
***Safer*** is a simple way to save Your precious passwords in a safe way. It doesn't use an internet connection, all data is saved locally on a device, so You don't have to worry about data leaks to the internet.
***Safer*** allows exporting Your data in case switching to new device or so on. It also can be a manual way to make a backup of Your data.

***Safer*** has been created for educational purposes and it would be still developed in the future.

IMPORTANT: All saved data on the device are encrypted. Exported backup file also. However, we still don't recommend storing very crucial information like bank account credentials.

**Use cases/Tools**:
- architecture uses in a majority **BLOC** pattern (based on cubits);
- changing app theme light/dark/system;
- changing app language english/polish/system;
- encryption of exported file with [aes_crypt](https://pub.dev/packages/aes_crypt) package - the only one used in project, which doesn't fulfill *null-safety*;
- [floor](https://pub.dev/packages/floor) package to mantain local **SQLite** database, 
- encryption of data in local databse using [encrypt](https://pub.dev/packages/encrypt);
- logging with use of PIN code, and also a possibility to turn on logging with biometric [local_auth](https://pub.dev/packages/local_auth);
- automatic logout after 1 minute of being app in background
- *dependency injection* with use of [get_it](https://pub.dev/packages/get_it) library.
