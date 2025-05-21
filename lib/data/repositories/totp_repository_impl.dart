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
}
