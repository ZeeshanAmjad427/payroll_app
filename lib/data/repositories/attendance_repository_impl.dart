import 'package:payroll/data/models/location_model/location_in_and_out_model.dart';
import 'package:payroll/data/models/location_model/update_attendance_model.dart';

import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance/attendance_remote_data_source.dart';
import '../models/location_model/attendance_model.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  AttendanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<bool> markAttendance(AttendanceModel attendanceModel) {
    return remoteDataSource.markAttendance(attendanceModel);
  }

  @override
  Future<bool> checkIn(LocationInAndOutModel checkIn) {
    return remoteDataSource.checkIn(checkIn);
  }

  @override
  Future<bool> checkOut(LocationInAndOutModel checkOut) {
    return remoteDataSource.checkOut(checkOut);
  }

  @override
  Future<bool> updateAttendance(UpdateAttendanceModel updateAttendanceModel) {
    return remoteDataSource.updateAttendance(updateAttendanceModel);
  }
}
