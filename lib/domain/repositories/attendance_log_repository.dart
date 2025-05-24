import 'package:payroll/data/models/attendance_log_model/attendance_log_model.dart';

abstract class AttendanceLogRepository {
  Future<List<AttendanceLogModel>> getAttendanceLogs(String employeeId, String month);
}
