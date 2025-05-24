import 'package:payroll/data/models/location_model/attendance_model.dart';
import 'package:payroll/data/models/location_model/location_in_and_out_model.dart';
import 'package:payroll/data/models/location_model/update_attendance_model.dart';

abstract class AttendanceRepository {
  Future<bool> markAttendance(AttendanceModel attendance);
  Future<bool> checkIn(LocationInAndOutModel checkIn);
  Future<bool> checkOut(LocationInAndOutModel checkOut);
  Future<bool> updateAttendance(UpdateAttendanceModel updateAttendanceModel);

}
