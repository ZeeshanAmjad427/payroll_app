class AttendanceLogModel {
  final String id;
  final String employeeId;
  final DateTime date;
  final String status;
  final DateTime timeIn;
  final DateTime timeOut;
  final String locationInId;
  final String locationOutId;
  final double hoursWorked;

  AttendanceLogModel({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.status,
    required this.timeIn,
    required this.timeOut,
    required this.locationInId,
    required this.locationOutId,
    required this.hoursWorked,
  });

  factory AttendanceLogModel.fromJson(Map<String, dynamic> json) {
    return AttendanceLogModel(
      id: json['id'] ?? '',
      employeeId: json['employeeId'] ?? '',
      date: DateTime.parse(json['date']),
      status: json['status'] ?? '',
      timeIn: DateTime.parse(json['timeIn']),
      timeOut: DateTime.parse(json['timeOut']),
      locationInId: json['locationInId'] ?? '',
      locationOutId: json['locationOutId'] ?? '',
      hoursWorked: (json['hoursWorked'] ?? 0).toDouble(),
    );
  }
}
