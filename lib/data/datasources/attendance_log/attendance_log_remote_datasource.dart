import 'package:dio/dio.dart';
import 'package:payroll/config/api_endpoints/api_endpoints.dart';
import '../../../dio_client/dio_client.dart';
import '../../models/attendance_log_model/attendance_log_model.dart';

class AttendanceLogRemoteDatasource {
  final DioClient dioClient;

  AttendanceLogRemoteDatasource(this.dioClient);

  Future<List<AttendanceLogModel>> fetchAttendanceLogs(String employeeId, String month) async {
    final response = await dioClient.dio.get(
      ApiEndpoints.getAttendanceLog,
      queryParameters: {
        'employeeId': employeeId,
        'month': month,
      },
    );

    return (response.data as List)
        .map((json) => AttendanceLogModel.fromJson(json))
        .toList();
  }
}
