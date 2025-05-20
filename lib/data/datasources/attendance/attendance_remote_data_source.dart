import 'package:dio/dio.dart';

import '../../models/location_model/attendance_model.dart';
import '../../models/location_model/location_in.dart';
import '../../models/location_model/location_out.dart';


class AttendanceRemoteDataSource {
  final Dio dio;
  AttendanceRemoteDataSource(this.dio);

  Future<String?> addLocationIn(LocationInModel locationIn) async {
    final response = await dio.post('/location-in', data: locationIn.toJson());
    if (response.statusCode == 200) {
      return response.data['locationId']; // adjust based on API response
    }
    return null;
  }

  Future<bool> addAttendance(AttendanceModel attendance) async {
    final response = await dio.post('/attendance', data: attendance.toJson());
    return response.statusCode == 200;
  }

  Future<String?> addLocationOut(LocationOutModel locationOut) async {
    final response = await dio.post('/location-out', data: locationOut.toJson());
    if (response.statusCode == 200) {
      return response.data['locationId'];
    }
    return null;
  }

  Future<bool> updateAttendance({
    required String employeeId,
    required String locationOutId,
    required DateTime timeOut,
  }) async {
    final response = await dio.put('/attendance/update', data: {
      'employeeId': employeeId,
      'locationOutId': locationOutId,
      'timeOut': timeOut.toIso8601String(),
    });
    return response.statusCode == 200;
  }
}
