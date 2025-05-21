import 'package:equatable/equatable.dart';

enum TotpStatus{initial,loading,success,failure}

class TotpState extends Equatable{
  const TotpState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.message = '',
    this.loginStatus = TotpStatus.initial,
    this.secretKey = ''
  });
  final String email;
  final String password;
  final bool isLoading;
  final String message;
  final TotpStatus loginStatus;
  final String? secretKey;

  TotpState copyWith({String?email,String?password,bool?isLoading,String?message,TotpStatus?loginStatus,String? secretKey}){
    return TotpState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      loginStatus: loginStatus ?? this.loginStatus,
      secretKey: secretKey ?? this.secretKey
    );
  }

  @override
  List<Object?> get props => [email,password,isLoading,message,loginStatus,secretKey];
}