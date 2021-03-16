import 'dart:async';

import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/SQLprovider.dart';

final appBloc =  AppBloc();

enum AppEvent{
  onStart, onAppInitialized, onStop
}

class AppBloc {
  final _appEventController = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get appEventsStream => _appEventController.stream;

  dispatch(AppEvent event) {
    switch(event) {
      case AppEvent.onStart:
        _initializeApp();
        _sinkEvent(AppEvent.onStart);
        break;
      case AppEvent.onStop:
        _dispose();
        _sinkEvent(AppEvent.onStop);
        break;
      case AppEvent.onAppInitialized:
        _sinkEvent(AppEvent.onAppInitialized);
        break;
    }
  }

  void _sinkEvent(AppEvent appEvent) => _appEventController.sink.add(appEvent);

  _dispose() {
    _appEventController.close();
  }

  void _initializeApp() async {
    await DataProvider.dp.initDataProvider();
    dispatch(AppEvent.onAppInitialized); // will execute when all initializations are complete,
  }
}