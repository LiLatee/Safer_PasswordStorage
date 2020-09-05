import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:mysimplepasswordstorage/utils/constants.dart';

class ExpandedPartBloc {
  ButtonState editButtonState = ButtonState.unpressed;
  bool isShowButtonPressed = false;

  PublishSubject<ButtonState> _subjectEditButton;
  PublishSubject<bool> _subjectShowButton;

  ExpandedPartBloc() {
    _subjectEditButton = PublishSubject<ButtonState>();
    _subjectShowButton = PublishSubject<bool>();
  }

  Stream<ButtonState> get editButtonStream => _subjectEditButton.stream;
  Stream<bool> get showButtonStream => _subjectShowButton.stream;

  void pressEditButton() {
    if (editButtonState == ButtonState.pressed) {
      editButtonState = ButtonState.unpressed;
    } else if (editButtonState == ButtonState.unpressed) {
      editButtonState = ButtonState.pressed;
    }
    _subjectEditButton.sink.add(editButtonState);
  }

  void pressShowButton() {
    isShowButtonPressed = !isShowButtonPressed;
    _subjectShowButton.sink.add(isShowButtonPressed);
  }
}
