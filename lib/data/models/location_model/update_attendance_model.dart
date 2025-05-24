class UpdateAttendanceModel {
  final String employeeId;
  final DateTime timeOut;
  final DateTime date;
  final String status;
  final String locationOutId;
  final int hoursWorked;

  UpdateAttendanceModel({
    required this.employeeId,
    required this.timeOut,
    required this.date,
    required this.status,
    required this.locationOutId,
    required this.hoursWorked,
  });

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'timeOut': timeOut.toIso8601String(),
      'date': date.toIso8601String(),
      'status': status,
      'locationOutId': locationOutId,
      'hoursWorked': hoursWorked,
    };
  }
}
