import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../config/api_endpoints/api_endpoints.dart';
import '../services/token_manager.dart';


class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptors
    dio.interceptors.addAll([
      _authInterceptor(),
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (obj) {
          assert(() {
            _logWithColor(obj.toString());
            return true;
          }());
        },
      ),
    ]);
  }

  // Method to log with color
  void _logWithColor(String log) {
    const String reset = '\x1B[0m';   // Reset color
    const String red = '\x1B[31m';    // Red color for errors
    const String green = '\x1B[32m';  // Green color for responses
    const String blue = '\x1B[34m';   // Blue color for requests
    const String yellow = '\x1B[33m'; // Yellow color for other logs

    void colorLog(String color, dynamic obj) {
      try {
        if (obj is String && (obj.startsWith('{') || obj.startsWith('['))) {
          final jsonObject = jsonDecode(obj);
          final compactJson = jsonEncode(jsonObject); // horizontal
          debugPrint('$color$compactJson$reset');
        } else {
          debugPrint('$color$obj$reset');
        }
      } catch (e) {
        debugPrint('$color$obj$reset'); // fallback
      }
    }

    if (log.contains('Request')) {
      colorLog(blue, log);
    } else if (log.contains('Response')) {
      colorLog(green, log);
    } else if (log.contains('Error')) {
      colorLog(red, log);
    } else {
      colorLog(yellow, log);
    }
  }

  InterceptorsWrapper _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await TokenManager.getAccessToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      // onError: (DioException error, handler) async {
      //   final response = error.response;
      //   if (response != null && _isJwtExpired(response.data)) {
      //     final refreshed = await _refreshToken();
      //     if (refreshed) {
      //       final newToken = await TokenManager.getAccessToken();
      //       final requestOptions = error.requestOptions;
      //
      //       // Retry the original request with new token
      //       requestOptions.headers['Authorization'] = 'Bearer $newToken';
      //       final cloneReq = await dio.fetch(requestOptions);
      //       return handler.resolve(cloneReq);
      //     }
      //     // else {
      //     //   SessionManager.showSessionExpiredDialog();
      //     //   return handler.reject(error);
      //     // }
      //   }
      //   return handler.next(error);
      // },
    );
  }

  bool _isJwtExpired(dynamic data) {
    try {
      return data['statusCode'] == "10001" &&
          (data['message']['en'] == "jwt expired" || data['message']['ar'] == "jwt expired");
    } catch (e) {
      return false;
    }
  }

  // Future<bool> _refreshToken() async {
  //   final refreshToken = await TokenManager.getRefreshToken();
  //   if (refreshToken == null) return false;
  //
  //   try {
  //     final response = await dio.post(
  //       ApiEndpoints.verifyRefreshToken,
  //       data: jsonEncode({'refreshToken': refreshToken}),
  //       options: Options(headers: {"Content-Type": "application/json"}),
  //     );
  //
  //     if (response.statusCode == 200 &&
  //         response.data['statusCode'] == "10000") {
  //       final data = response.data['data'];
  //       await TokenManager.saveTokens(
  //         accessToken: data['accessToken'],
  //         refreshToken: data['refreshToken'],
  //       );
  //       return true;
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     // Log error if needed
  //   }
  //
  //   return false;
  // }
}