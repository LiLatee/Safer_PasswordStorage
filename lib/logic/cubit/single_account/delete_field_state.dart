part of 'delete_field_cubit.dart';

abstract class DeleteFieldState extends Equatable {
  const DeleteFieldState();

  @override
  List<Object> get props => [];
}

class DeleteFieldInitial extends DeleteFieldState {}

class DeletingField extends DeleteFieldState {}

class DeletedField extends DeleteFieldState {}
