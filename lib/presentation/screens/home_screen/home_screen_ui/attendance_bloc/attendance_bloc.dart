import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/usecases/attendance_usecase.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceUseCase attendanceUseCase;

  AttendanceBloc(this.attendanceUseCase) : super(AttendanceState()) {
    on<MarkAttendanceEvent>(_onMarkAttendance);
  }

  Future<void> _onMarkAttendance(
      MarkAttendanceEvent event,
      Emitter<AttendanceState> emit,
      ) async {
    emit(AttendanceState(loginStatus: MarkAttendanceStatus.loading));

    try {
      final success = await attendanceUseCase.markAttendance(event.attendanceModel);
      if (success) {
        emit(AttendanceState(loginStatus: MarkAttendanceStatus.success));
      } else {
        emit(AttendanceState(loginStatus: MarkAttendanceStatus.success));
      }
    } catch (e) {
      emit(AttendanceState(loginStatus: MarkAttendanceStatus.success));
    }
  }

}
