import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance/attendance_remote_data_source.dart';
import '../models/location_model/attendance_model.dart';
import '../models/location_model/location_in.dart';
import '../models/location_model/location_out.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;
  AttendanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<String?> addLocationIn(String employeeId, double latitude, double longitude) {
    final locationInModel = LocationInModel(employeeId: employeeId, latitude: latitude, longitude: longitude);
    return remoteDataSource.addLocationIn(locationInModel);
  }

  @override
  Future<bool> addAttendance(String employeeId, DateTime date, String status, DateTime timeIn, String locationInId) {
    final attendanceModel = AttendanceModel(
      employeeId: employeeId,
      date: date,
      status: status,
      timeIn: timeIn,
      locationInId: locationInId,
      hoursWorked: 0,
    );
    return remoteDataSource.addAttendance(attendanceModel);
  }

  @override
  Future<String?> addLocationOut(String employeeId, double latitude, double longitude) {
    final locationOutModel = LocationOutModel(employeeId: employeeId, latitude: latitude, longitude: longitude);
    return remoteDataSource.addLocationOut(locationOutModel);
  }

  @override
  Future<bool> updateAttendance(String employeeId, String locationOutId, DateTime timeOut) {
    return remoteDataSource.updateAttendance(
      employeeId: employeeId,
      locationOutId: locationOutId,
      timeOut: timeOut,
    );
  }
}
