part of 'export_data_cubit.dart';

abstract class ExportDataState extends Equatable {
  const ExportDataState();

  @override
  List<Object> get props => [];
}

class ExportDataInitial extends ExportDataState {}

class ExportingData extends ExportDataState {}

class ExportedData extends ExportDataState {
  final String exportedDataLocation;

  ExportedData({required this.exportedDataLocation});
}

class ExportError extends ExportDataState {}
