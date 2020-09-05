import 'package:rxdart/rxdart.dart';

import 'package:mysimplepasswordstorage/utils/constants.dart';

class ExpandedPartBloc {
  ButtonState editButtonState = ButtonState.unpressed;
  BehaviorSubject<ButtonState> _subjectEditButton;

  ExpandedPartBloc({
    this.editButtonState,
  }) {
    _subjectEditButton = BehaviorSubject<ButtonState>.seeded(editButtonState);
  }

  Stream<ButtonState> get editButtonStream => _subjectEditButton.stream;

  void pressEditButton() {
    if (editButtonState == ButtonState.pressed) {
      editButtonState = ButtonState.unpressed;
    } else if (editButtonState == ButtonState.unpressed) {
      editButtonState = ButtonState.pressed;
    }
    _subjectEditButton.sink.add(editButtonState);
  }
}
