import 'package:payroll/data/models/totp_model/verify_totp_request_model.dart';
import 'package:payroll/data/models/totp_model/verify_totp_response_model.dart';

import '../../data/models/totp_model/on_totp_request_model.dart';
import '../../data/models/totp_model/totp_response_model.dart';

abstract class TotpRepository {
  Future<TotpResponseModel> getTotp();

  Future<TotpResponseModel> on2faEvent(OnTotpRequestModel request);

  Future<TotpResponseModel> on2faRemoveEvent(String userId);

  Future<VerifyTotpResponseModel> verifyTotp(VerifyTotpRequestModel request);
}
