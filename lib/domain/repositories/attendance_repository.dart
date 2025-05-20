abstract class AttendanceRepository {
  Future<String?> addLocationIn(String employeeId, double latitude, double longitude);
  Future<bool> addAttendance(String employeeId, DateTime date, String status, DateTime timeIn, String locationInId);
  Future<String?> addLocationOut(String employeeId, double latitude, double longitude);
  Future<bool> updateAttendance(String employeeId, String locationOutId, DateTime timeOut);
}
