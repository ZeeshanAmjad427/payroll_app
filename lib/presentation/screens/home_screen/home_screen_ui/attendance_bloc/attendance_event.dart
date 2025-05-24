import 'package:payroll/data/models/location_model/location_in_and_out_model.dart';
import 'package:payroll/data/models/location_model/update_attendance_model.dart';

import '../../../../../data/models/location_model/attendance_model.dart';

abstract class AttendanceEvent {}

class MarkAttendanceEvent extends AttendanceEvent {
  final AttendanceModel attendanceModel;

  MarkAttendanceEvent({required this.attendanceModel});
}

class CheckInEvent extends AttendanceEvent{
  final LocationInAndOutModel locationInAndOutModel;

  CheckInEvent({required this.locationInAndOutModel});
}

class CheckOutEvent extends AttendanceEvent{
  final LocationInAndOutModel locationInAndOutModel;

  CheckOutEvent({required this.locationInAndOutModel});
}

class UpdateAttendanceEvent extends AttendanceEvent{
  final UpdateAttendanceModel updateAttendanceModel;

  UpdateAttendanceEvent({required this.updateAttendanceModel});
}
