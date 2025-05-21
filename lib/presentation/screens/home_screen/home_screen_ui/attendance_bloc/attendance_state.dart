import 'package:equatable/equatable.dart';

enum MarkAttendanceStatus{initial,loading,success,failure}

class AttendanceState extends Equatable{
  const AttendanceState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.message = '',
    this.loginStatus = MarkAttendanceStatus.initial,
  });
  final String email;
  final String password;
  final bool isLoading;
  final String message;
  final MarkAttendanceStatus loginStatus;

  AttendanceState copyWith({String?email,String?password,bool?isLoading,String?message,MarkAttendanceStatus?loginStatus}){
    return AttendanceState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  List<Object?> get props => [email,password,isLoading,message,loginStatus];
}