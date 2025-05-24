class VerifyTotpResponseModel {
  final bool isApiHandled;
  final bool isRequestSuccess;
  final int statusCode;
  final String message;
  final TotpVerificationData? data;
  final List<dynamic> exception;

  VerifyTotpResponseModel({
    required this.isApiHandled,
    required this.isRequestSuccess,
    required this.statusCode,
    required this.message,
    this.data,
    required this.exception,
  });

  factory VerifyTotpResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyTotpResponseModel(
      isApiHandled: json['isApiHandled'] ?? false,
      isRequestSuccess: json['isRequestSuccess'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? TotpVerificationData.fromJson(json['data']) : null,
      exception: json['exception'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isApiHandled': isApiHandled,
      'isRequestSuccess': isRequestSuccess,
      'statusCode': statusCode,
      'message': message,
      'data': data?.toJson(),
      'exception': exception,
    };
  }
}

class TotpVerificationData {
  final int timeMatched;
  final bool isVerified;

  TotpVerificationData({
    required this.timeMatched,
    required this.isVerified,
  });

  factory TotpVerificationData.fromJson(Map<String, dynamic> json) {
    return TotpVerificationData(
      timeMatched: json['timeMatched'] ?? 0,
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timeMatched': timeMatched,
      'isVerified': isVerified,
    };
  }
}
