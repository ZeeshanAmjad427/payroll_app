import 'package:equatable/equatable.dart';

import '../../../../data/models/totp_model/verify_totp_response_model.dart';

enum TotpStatus{initial,loading,success,failure,removeSuccess}

class TotpState extends Equatable{
  const TotpState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.message = '',
    this.loginStatus = TotpStatus.initial,
    this.secretKey = '',
    this.verifyTotpResponseModel,
    this.isTotp = false,
  });
  final String email;
  final String password;
  final bool isLoading;
  final String message;
  final TotpStatus loginStatus;
  final String? secretKey;
  final VerifyTotpResponseModel? verifyTotpResponseModel;
  final bool isTotp;

  TotpState copyWith({String?email,String?password,bool?isLoading,String?message,TotpStatus?loginStatus,String? secretKey,VerifyTotpResponseModel? verifyTotpResponseModel,bool?isTotp}){
    return TotpState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      loginStatus: loginStatus ?? this.loginStatus,
      secretKey: secretKey ?? this.secretKey,
      verifyTotpResponseModel: verifyTotpResponseModel ?? this.verifyTotpResponseModel,
      isTotp: isTotp ?? this.isTotp,
    );
  }

  @override
  List<Object?> get props => [email,password,isLoading,message,loginStatus,secretKey,verifyTotpResponseModel,isTotp];
}