part of 'phone_lock_cubit.dart';

abstract class PhoneLockState extends Equatable {
  const PhoneLockState();

  @override
  List<Object> get props => [];
}

class PhoneLockInitial extends PhoneLockState {}

class PhoneHasLock extends PhoneLockState {}

class PhoneHasNotLock extends PhoneLockState {}
