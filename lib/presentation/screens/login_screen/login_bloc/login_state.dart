import 'package:equatable/equatable.dart';

enum LoginStatus{initial,loading,success,failure}

class LoginState extends Equatable{
  const LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.message = '',
    this.loginStatus = LoginStatus.initial,
});
  final String email;
  final String password;
  final bool isLoading;
  final String message;
  final LoginStatus loginStatus;

  LoginState copyWith({String?email,String?password,bool?isLoading,String?message,LoginStatus?loginStatus}){
    return LoginState(
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