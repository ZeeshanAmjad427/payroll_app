import 'package:dio/dio.dart';
import 'package:payroll/config/api_endpoints/api_endpoints.dart';
import 'package:payroll/data/models/location_model/location_in_and_out_model.dart';
import 'package:payroll/data/models/location_model/update_attendance_model.dart';
import 'package:payroll/dio_client/dio_client.dart';
import '../../models/location_model/attendance_model.dart';


class AttendanceRemoteDataSource {
  final dio = DioClient().dio;

  Future<bool> markAttendance(AttendanceModel attendance) async {
    final response = await dio.post(ApiEndpoints.addAttendanceUrl, data: attendance.toJson());
    return response.statusCode == 200;
  }
  Future<bool> checkIn(LocationInAndOutModel checkIn) async {
    final response = await dio.post(ApiEndpoints.addLocationInUrl, data: checkIn.toJson());
    return response.statusCode == 200;
  }
  Future<bool> checkOut(LocationInAndOutModel checkOut) async {
    final response = await dio.post(ApiEndpoints.addLocationOutUrl, data: checkOut.toJson());
    return response.statusCode == 200;
  }
  Future<bool> updateAttendance(UpdateAttendanceModel updateAttendance) async {
    final response = await dio.post(ApiEndpoints.updateAttendanceUrl, data: updateAttendance.toJson());
    return response.statusCode == 200;
  }

}
