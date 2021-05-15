import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class SqlLiteFailure extends Failure {
  final String message;

  SqlLiteFailure({required this.message});
}

class BackupEncryptionFailure extends Failure {
  final String message;

  BackupEncryptionFailure(this.message);
  @override
  String toString() {
    return "BackupDecryptionFailure - $message";
  }
}

class BackupDecryptionFailure extends Failure {
  final String message;

  BackupDecryptionFailure(this.message);
  @override
  String toString() {
    return "BackupDecryptionFailure - $message";
  }
}

class ReadWritePermissionNotGrantedFailure extends Failure {}
