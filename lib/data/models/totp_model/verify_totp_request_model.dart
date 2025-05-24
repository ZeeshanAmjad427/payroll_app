class VerifyTotpRequestModel {
  final String secetKey;
  final String totpCode;
  final int timeLimitInSec;
  final int numOfDigits;

  VerifyTotpRequestModel({
    required this.secetKey,
    required this.totpCode,
    required this.timeLimitInSec,
    required this.numOfDigits,
  });

  Map<String, dynamic> toJson() {
    return {
      'secetKey': secetKey,
      'totpCode': totpCode,
      'timeLimitInSec': timeLimitInSec,
      'numOfDigits': numOfDigits,
    };
  }
}
