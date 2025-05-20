class Attendance {
  final String employeeId;
  final DateTime date;
  final String status;
  final DateTime timeIn;
  final String locationInId;
  final int hoursWorked;

  Attendance({
    required this.employeeId,
    required this.date,
    required this.status,
    required this.timeIn,
    required this.locationInId,
    required this.hoursWorked,
  });
}
