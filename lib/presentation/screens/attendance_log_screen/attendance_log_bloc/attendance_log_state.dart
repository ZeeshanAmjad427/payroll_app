
import 'package:equatable/equatable.dart';
import 'package:payroll/data/models/attendance_log_model/attendance_log_model.dart';

abstract class AttendanceLogState extends Equatable {
  const AttendanceLogState();

  @override
  List<Object> get props => [];
}

class AttendanceLogInitial extends AttendanceLogState {}

class AttendanceLogLoading extends AttendanceLogState {}

class AttendanceLogLoaded extends AttendanceLogState {
  final List<AttendanceLogModel> logs;

  const AttendanceLogLoaded(this.logs);

  @override
  List<Object> get props => [logs];
}

class AttendanceLogError extends AttendanceLogState {
  final String message;

  const AttendanceLogError(this.message);

  @override
  List<Object> get props => [message];
}
