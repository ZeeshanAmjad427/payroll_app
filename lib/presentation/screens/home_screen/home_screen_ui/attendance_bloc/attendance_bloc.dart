import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/models/location_model/update_attendance_model.dart';
import '../../../../../domain/usecases/attendance_usecase.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceUseCase attendanceUseCase;

  AttendanceBloc(this.attendanceUseCase) : super(AttendanceState()) {
    on<MarkAttendanceEvent>(_onMarkAttendance);
    on<CheckInEvent>(_onCheckIn);
    on<CheckOutEvent>(_onCheckOut);
    on<UpdateAttendanceEvent>(_updateAttendance);

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

  Future<void> _onCheckIn(
      CheckInEvent event,
      Emitter<AttendanceState>emit,
      ) async {
    emit(AttendanceState(loginStatus: MarkAttendanceStatus.loading));

    try{
      final success = await attendanceUseCase.checkIn(event.locationInAndOutModel);
      if (success) {
        emit(AttendanceState(loginStatus: MarkAttendanceStatus.success));
      }
    } catch(e) {
      emit(AttendanceState(loginStatus: MarkAttendanceStatus.success));
    }
  }

  Future<void> _onCheckOut(
      CheckOutEvent event,
      Emitter<AttendanceState>emit,
      ) async {
    emit(AttendanceState(loginStatus: MarkAttendanceStatus.loading));

    try{
      final success = await attendanceUseCase.checkOut(event.locationInAndOutModel);
      if (success) {
        emit(AttendanceState(loginStatus: MarkAttendanceStatus.success));
      }
    }catch(e){
      emit(AttendanceState(loginStatus: MarkAttendanceStatus.failure));
    }
  }

  Future<void> _updateAttendance(
      UpdateAttendanceEvent event,
      Emitter<AttendanceState>emit,
      ) async {
    emit(AttendanceState(loginStatus: MarkAttendanceStatus.loading));

    try{
      final success = await attendanceUseCase.updateAttendance(event.updateAttendanceModel);
      if (success) {
        emit(AttendanceState(loginStatus: MarkAttendanceStatus.success));
      }
    }catch(e){
      emit(AttendanceState(loginStatus: MarkAttendanceStatus.failure));
    }
  }
}
