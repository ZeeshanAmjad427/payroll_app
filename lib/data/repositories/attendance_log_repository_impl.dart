import 'package:payroll/data/models/attendance_log_model/attendance_log_model.dart';
import 'package:payroll/domain/repositories/attendance_log_repository.dart';
import '../datasources/attendance_log/attendance_log_remote_datasource.dart';

class AttendanceLogRepositoryImpl implements AttendanceLogRepository {
  final AttendanceLogRemoteDatasource remoteDataSource;

  AttendanceLogRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AttendanceLogModel>> getAttendanceLogs(String employeeId, String month) async {
    return await remoteDataSource.fetchAttendanceLogs(employeeId, month);
  }
}
