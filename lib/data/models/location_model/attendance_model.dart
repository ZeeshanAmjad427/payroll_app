class AttendanceModel {
  final String employeeId;
  final DateTime date;
  final String status;
  final DateTime timeIn;
  final String locationInId;
  final int hoursWorked;

  AttendanceModel({
    required this.employeeId,
    required this.date,
    required this.status,
    required this.timeIn,
    required this.locationInId,
    required this.hoursWorked,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      employeeId: json['employeeId'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      timeIn: DateTime.parse(json['timeIn']),
      locationInId: json['locationInId'],
      hoursWorked: json['hoursWorked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'employeeId': employeeId,
      'date': date.toIso8601String(),
      'status': status,
      'timeIn': timeIn.toIso8601String(),
      'locationInId': locationInId,
      'hoursWorked': hoursWorked,
    };
  }
}
