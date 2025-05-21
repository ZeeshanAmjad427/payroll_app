import '../../../../../data/models/location_model/attendance_model.dart';

abstract class AttendanceEvent {}

class MarkAttendanceEvent extends AttendanceEvent {
  final AttendanceModel attendanceModel;

  MarkAttendanceEvent({required this.attendanceModel});
}
