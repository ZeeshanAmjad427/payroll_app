import 'package:dio/dio.dart';
import 'package:payroll/config/api_endpoints/api_endpoints.dart';
import 'package:payroll/data/models/totp_model/verify_totp_request_model.dart';
import 'package:payroll/data/models/totp_model/verify_totp_response_model.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_event.dart';
import '../../../dio_client/dio_client.dart';
import '../../models/totp_model/on_totp_request_model.dart';
import '../../models/totp_model/totp_response_model.dart';

abstract class TotpRemoteDataSource {
  Future<TotpResponseModel> getTotp();
  Future<TotpResponseModel> on2faEvent(OnTotpRequestModel request);
  Future<TotpResponseModel> on2faRemoveEvent(String userId);
  Future<VerifyTotpResponseModel> verifyTotp(VerifyTotpRequestModel request); // <-- Fix here
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

      if (response.statusCode == 201) {
        return TotpResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch TOTP: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('TOTP request error: $e');
    }
  }

  @override
  Future<TotpResponseModel> on2faRemoveEvent(String userId) async {
    try {
      final response = await dioClient.dio.post(ApiEndpoints.remove2FA,
        data: {
          "userId": userId,
        },
      );

      if (response.statusCode == 201) {
        return TotpResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to fetch TOTP: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('TOTP request error: $e');
    }
  }

  @override
  Future<VerifyTotpResponseModel> verifyTotp(VerifyTotpRequestModel request) async {
    try {
      final response = await dioClient.dio.post("https://prodgateway.lockkeyz.com/TOTP/ITOTPFeature/ExposedVerifyCode",data: request.toJson(),options:
      Options(
        headers: {
          'DeviceId': "123456", // <-- Set deviceId in header
        },
      )
      );

      if (response.statusCode == 200) {
        return VerifyTotpResponseModel.fromJson(response.data);
      }
      else {
        print("OTP ERROR: ${response.statusMessage}");
        throw Exception('Failed to fetch TOTP: ${response.statusMessage}');
      }
    } catch (e) {
      print("OTP CRASH: ${e.toString()}");
      throw Exception('TOTP request error: $e');
    }
  }
}
