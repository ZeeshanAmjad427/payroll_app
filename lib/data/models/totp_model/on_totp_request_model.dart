class OnTotpRequestModel {
  final String userId;
  final String secretKey;
  final bool isTotp;

  OnTotpRequestModel({
    required this.userId,
    required this.secretKey,
    required this.isTotp,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'secretKey': secretKey,
      'isTotp': isTotp,
    };
  }
}
