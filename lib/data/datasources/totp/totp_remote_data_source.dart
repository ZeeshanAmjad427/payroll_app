import 'package:dio/dio.dart';
import 'package:payroll/config/api_endpoints/api_endpoints.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_event.dart';
import '../../../dio_client/dio_client.dart';
import '../../models/totp_model/on_totp_request_model.dart';
import '../../models/totp_model/totp_response_model.dart';

abstract class TotpRemoteDataSource {
  Future<TotpResponseModel> getTotp();
  Future<TotpResponseModel> on2faEvent(OnTotpRequestModel request);

}

class TotpRemoteDataSourceImpl implements TotpRemoteDataSource {
  final DioClient dioClient;

  TotpRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<TotpResponseModel> getTotp() async {
    try {
      final response = await dioClient.dio.get("https://prodgateway.lockkeyz.com/TOTP/ITOTPFeature/ExposedGetSecretKey");

      if (response.statusCode == 200) {
        return TotpResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch TOTP: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('TOTP request error: $e');
    }
  }

  @override
  Future<TotpResponseModel> on2faEvent(OnTotpRequestModel request) async {
    try {
      final response = await dioClient.dio.post(ApiEndpoints.add2FA,data: request.toJson());

      if (response.statusCode == 200) {
        return TotpResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch TOTP: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('TOTP request error: $e');
    }
  }
}
