import '../../../domain/entities/location/attendance.dart';

class AttendanceModel extends Attendance {
  AttendanceModel({
    required String employeeId,
    required DateTime date,
    required String status,
    required DateTime timeIn,
    required String locationInId,
    required int hoursWorked,
  }) : super(
    employeeId: employeeId,
    date: date,
    status: status,
    timeIn: timeIn,
    locationInId: locationInId,
    hoursWorked: hoursWorked,
  );

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
