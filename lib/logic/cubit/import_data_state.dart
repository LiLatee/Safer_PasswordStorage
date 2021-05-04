part of 'import_data_cubit.dart';

abstract class ImportDataState extends Equatable {
  const ImportDataState();

  @override
  List<Object> get props => [];
}

class ImportDataInitial extends ImportDataState {}

class ImportingData extends ImportDataState {}

class ImportedData extends ImportDataState {}

class ImportError extends ImportDataState {}
