abstract class AttendanceEvent {}

class CheckInEvent extends AttendanceEvent {
  final String employeeId;
  final double latitude;
  final double longitude;

  CheckInEvent({
    required this.employeeId,
    required this.latitude,
    required this.longitude,
  });
}

class CheckOutEvent extends AttendanceEvent {
  final String employeeId;
  final double latitude;
  final double longitude;

  CheckOutEvent({
    required this.employeeId,
    required this.latitude,
    required this.longitude,
  });
}
