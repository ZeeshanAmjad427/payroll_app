import '../repositories/attendance_repository.dart';

class AttendanceUseCase {
  final AttendanceRepository repository;

  AttendanceUseCase(this.repository);

  Future<bool> checkIn({
    required String employeeId,
    required double latitude,
    required double longitude,
  }) async {
    final locationInId = await repository.addLocationIn(employeeId, latitude, longitude);
    if (locationInId == null) return false;

    final success = await repository.addAttendance(
      employeeId,
      DateTime.now(),
      "Present",
      DateTime.now(),
      locationInId,
    );
    return success;
  }

  Future<bool> checkOut({
    required String employeeId,
    required double latitude,
    required double longitude,
  }) async {
    final locationOutId = await repository.addLocationOut(employeeId, latitude, longitude);
    if (locationOutId == null) return false;

    final success = await repository.updateAttendance(
      employeeId,
      locationOutId,
      DateTime.now(),
    );
    return success;
  }
}
