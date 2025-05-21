class TotpResponseModel {
  final bool isApiHandled;
  final bool isRequestSuccess;
  final int statusCode;
  final String message;
  final String data;
  final List<dynamic> exception;

  TotpResponseModel({
    required this.isApiHandled,
    required this.isRequestSuccess,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.exception,
  });

  factory TotpResponseModel.fromJson(Map<String, dynamic> json) {
    return TotpResponseModel(
      isApiHandled: json['isApiHandled'] ?? false,
      isRequestSuccess: json['isRequestSuccess'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] ?? '',
      exception: json['exception'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isApiHandled': isApiHandled,
      'isRequestSuccess': isRequestSuccess,
      'statusCode': statusCode,
      'message': message,
      'data': data,
      'exception': exception,
    };
  }
}
