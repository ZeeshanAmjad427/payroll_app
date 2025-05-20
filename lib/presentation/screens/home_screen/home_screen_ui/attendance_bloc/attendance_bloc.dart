import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../domain/usecases/attendance_usecase.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceUseCase attendanceUseCase;

  AttendanceBloc(this.attendanceUseCase) : super(AttendanceInitial()) {
    on<CheckInEvent>(_onCheckIn);
    on<CheckOutEvent>(_onCheckOut);
  }

  Future<void> _onCheckIn(CheckInEvent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final success = await attendanceUseCase.checkIn(
        employeeId: event.employeeId,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      if (success) {
        emit(AttendanceSuccess("Checked in successfully"));
      } else {
        emit(AttendanceFailure("Check-in failed"));
      }
    } catch (e) {
      emit(AttendanceFailure("Check-in failed: ${e.toString()}"));
    }
  }

  Future<void> _onCheckOut(CheckOutEvent event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final success = await attendanceUseCase.checkOut(
        employeeId: event.employeeId,
        latitude: event.latitude,
        longitude: event.longitude,
      );
      if (success) {
        emit(AttendanceSuccess("Checked out successfully"));
      } else {
        emit(AttendanceFailure("Check-out failed"));
      }
    } catch (e) {
      emit(AttendanceFailure("Check-out failed: ${e.toString()}"));
    }
  }
}
