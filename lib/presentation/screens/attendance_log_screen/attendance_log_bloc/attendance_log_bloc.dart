import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/usecases/attendance_log_usecase.dart';
import 'attendace_log_event.dart';
import 'attendance_log_state.dart';

class AttendanceLogBloc extends Bloc<AttendanceLogEvent, AttendanceLogState> {
  final AttendanceLogsUseCase attendanceLogsUseCase;

  AttendanceLogBloc(this.attendanceLogsUseCase) : super(AttendanceLogInitial()) {
    on<FetchAttendanceLogs>((event, emit) async {
      emit(AttendanceLogLoading());
      try {
        final logs = await attendanceLogsUseCase.getAttendanceLogs(
          event.employeeId,
          event.month,
        );
        emit(AttendanceLogLoaded(logs));
      } catch (e) {
        emit(AttendanceLogError("Failed to fetch attendance logs"));
      }
    });
  }
}
