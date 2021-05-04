part of 'add_account_cubit.dart';

abstract class AddAccountState extends Equatable {
  const AddAccountState();

  @override
  List<Object> get props => [];
}

class AddAccountInitial extends AddAccountState {}

class Adding extends AddAccountState {}

class AddedAccount extends AddAccountState {}
