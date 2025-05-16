import 'package:payroll/data/models/auth_model/login_response_model.dart';

abstract class AuthRepository {
  Future<LoginResponseModel> login({required String email, required String password});
}
