import 'package:payroll/data/models/attendance_log_model/attendance_log_model.dart';
import 'package:payroll/domain/repositories/attendance_log_repository.dart';

class AttendanceLogsUseCase {
  final AttendanceLogRepository repository;

  AttendanceLogsUseCase(this.repository);

  Future<List<AttendanceLogModel>> getAttendanceLogs(String employeeId, String month) {
    return repository.getAttendanceLogs(employeeId, month);
  }
}
