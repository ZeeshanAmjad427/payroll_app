import '../../data/models/totp_model/on_totp_request_model.dart';
import '../../data/models/totp_model/totp_response_model.dart';
import '../repositories/totp_repository.dart';

class GetTotpUseCase {
  final TotpRepository repository;

  GetTotpUseCase({required this.repository});

  Future<TotpResponseModel> getTotp() {
    return repository.getTotp();
  }

  Future<TotpResponseModel> on2faEvent(OnTotpRequestModel request) {
    return repository.on2faEvent(request);
  }
}
