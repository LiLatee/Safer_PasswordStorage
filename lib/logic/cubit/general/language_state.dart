part of 'language_cubit.dart';

class LanguageState extends Equatable {
  String languageCode;
  LanguageState({required this.languageCode});

  @override
  List<Object> get props => [languageCode];
}

// class LanguageInitial extends LanguageState {}
