import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../config/api_endpoints/api_endpoints.dart';
import '../../../dio_client/dio_client.dart';
import '../../models/auth_model/login_request_model.dart';
import '../../models/auth_model/login_response_model.dart';

class LoginRemoteDataSource {
  final DioClient dioClient;

  LoginRemoteDataSource(this.dioClient);

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    try {
      final response = await dioClient.dio.post(
        ApiEndpoints.loginUrl,
        data: jsonEncode(requestModel.toJson()),
      );
      return LoginResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      return LoginResponseModel(
        isApiHandled: true,
        isRequestSuccess: false,
        statusCode: e.response?.statusCode ?? 500,
        message: e.response?.data['message'] ?? 'Something went wrong',
        data: null,
        exception: [e.toString()],
      );
    }
  }
}
