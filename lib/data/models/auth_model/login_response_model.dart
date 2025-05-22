class LoginDataModel {
  final String name;
  final String email;
  final String userId;
  final String userType;
  final String token;
  final String refreshToken;
  final String? secretKey;
  final bool isTotp;
  final List<RoleAndAction> roleAndActions;

  LoginDataModel({
    required this.name,
    required this.email,
    required this.userId,
    required this.userType,
    required this.token,
    required this.refreshToken,
    required this.secretKey,
    required this.isTotp,
    required this.roleAndActions,
  });

  factory LoginDataModel.fromJson(Map<String, dynamic> json) {
    return LoginDataModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      userId: json['userId'] ?? '',
      userType: json['userType'] ?? '',
      token: json['token'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      secretKey: json['secretKey'], // Nullable
      isTotp: json['isTotp'] ?? false,
      roleAndActions: (json['roleAndActions'] as List<dynamic>?)
          ?.map((e) => RoleAndAction.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class LoginResponseModel {
  final bool isApiHandled;
  final bool isRequestSuccess;
  final int statusCode;
  final String message;
  final LoginDataModel? data;
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
      data: json['data'] != null ? LoginDataModel.fromJson(json['data']) : null,
      exception: json['exception'] ?? [],
    );
  }
}

class RoleAndAction {
  final String userRoleAssignDate;
  final List<dynamic> actions;
  final String createdBy;
  final String updatedBy;
  final String updatedDate;
  final String createdDate;
  final bool isActive;
  final String id;
  final String name;
  final String tag;

  RoleAndAction({
    required this.userRoleAssignDate,
    required this.actions,
    required this.createdBy,
    required this.updatedBy,
    required this.updatedDate,
    required this.createdDate,
    required this.isActive,
    required this.id,
    required this.name,
    required this.tag,
  });

  factory RoleAndAction.fromJson(Map<String, dynamic> json) {
    return RoleAndAction(
      userRoleAssignDate: json['userRoleAssignDate'] ?? '',
      actions: json['actions'] ?? [],
      createdBy: json['createdBy'] ?? '',
      updatedBy: json['updatedBy'] ?? '',
      updatedDate: json['updatedDate'] ?? '',
      createdDate: json['createdDate'] ?? '',
      isActive: json['isActive'] ?? false,
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      tag: json['tag'] ?? '',
    );
  }
}
