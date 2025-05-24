
import 'package:equatable/equatable.dart';

abstract class AttendanceLogEvent extends Equatable {
  const AttendanceLogEvent();

  @override
  List<Object> get props => [];
}

class FetchAttendanceLogs extends AttendanceLogEvent {
  final String employeeId;
  final String month;

  const FetchAttendanceLogs(this.employeeId, this.month);

  @override
  List<Object> get props => [employeeId, month];
}
