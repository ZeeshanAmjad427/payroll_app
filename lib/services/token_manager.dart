import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _employeeId = 'employee_id';
  static const String _secretKey = 'secret_key';
  static const String _isTotp = 'is_totp';
  static const String _isTotpVerified = 'is_totp_verified';

  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String employeeId,
    String? secretKey,
    bool? isTotp,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_employeeId, employeeId);

    if (secretKey != null) {
      await prefs.setString(_secretKey, secretKey);
    }

    if (isTotp != null) {
      await prefs.setBool(_isTotp, isTotp);
    }
  }

  static Future<void> setTotpVerified(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isTotpVerified, value);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<String?> getEmployeeId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_employeeId);
  }

  static Future<String?> getSecretKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_secretKey);
  }

  static Future<bool?> getIsTotp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isTotp);
  }

  static Future<bool?> getTotpVerified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isTotpVerified);
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.remove(_employeeId);
    await prefs.remove(_secretKey);
    await prefs.remove(_isTotp);
    await prefs.remove(_isTotpVerified);
  }

  static Future<void> setSecretKey(String secretKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_secretKey, secretKey);
  }
}
