import 'package:payroll/data/models/location_model/location_in_and_out_model.dart';

import '../../data/models/location_model/attendance_model.dart';
import '../repositories/attendance_repository.dart';

class AttendanceUseCase {
  final AttendanceRepository repository;

  AttendanceUseCase(this.repository);

  Future<bool> markAttendance(AttendanceModel attendance) {
    return repository.markAttendance(attendance);
  }
  Future<bool> checkIn(LocationInAndOutModel checkIn) {
    return repository.checkIn(checkIn);
  }
}
