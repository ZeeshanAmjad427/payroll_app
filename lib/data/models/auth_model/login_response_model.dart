class LoginResponseModel {
  final bool isApiHandled;
  final bool isRequestSuccess;
  final int statusCode;
  final String message;
  final dynamic data; // You can replace `dynamic` with a specific model if `data` is non-null
  final List<dynamic> exception;

  LoginResponseModel({
    required this.isApiHandled,
    required this.isRequestSuccess,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.exception,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      isApiHandled: json['isApiHandled'] ?? false,
      isRequestSuccess: json['isRequestSuccess'] ?? false,
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'],
      exception: json['exception'] ?? [],
    );
  }
}
