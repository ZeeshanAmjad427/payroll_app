import 'package:payroll/data/models/totp_model/verify_totp_request_model.dart';
import 'package:payroll/data/models/totp_model/verify_totp_response_model.dart';

import '../../domain/repositories/totp_repository.dart';
import '../datasources/totp/totp_remote_data_source.dart';
import '../models/totp_model/on_totp_request_model.dart';
import '../models/totp_model/totp_response_model.dart';

class TotpRepositoryImpl implements TotpRepository {
  final TotpRemoteDataSource remoteDataSource;

  TotpRepositoryImpl({required this.remoteDataSource});

  @override
  Future<TotpResponseModel> getTotp() {
    return remoteDataSource.getTotp();
  }

@override
  Future<TotpResponseModel> on2faEvent(OnTotpRequestModel request) {
    return remoteDataSource.on2faEvent(request);
  }

@override
Future<TotpResponseModel> on2faRemoveEvent(String userId) {
    return remoteDataSource.on2faRemoveEvent(userId);
  }

  @override
  Future<VerifyTotpResponseModel> verifyTotp(VerifyTotpRequestModel request) {
    return remoteDataSource.verifyTotp(request);
  }

}
