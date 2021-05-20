part of 'add_field_cubit.dart';

abstract class AddFieldState extends Equatable {
  const AddFieldState();

  @override
  List<Object> get props => [];
}

class AddFieldInitial extends AddFieldState {}

class AddingField extends AddFieldState {}

class AddedField extends AddFieldState {}
