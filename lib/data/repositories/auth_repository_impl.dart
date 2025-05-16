
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth/LoginRemoteDataSource.dart';
import '../models/auth_model/login_request_model.dart';
import '../models/auth_model/login_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LoginRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final requestModel = LoginRequestModel(email: email, password: password);
    return await remoteDataSource.login(requestModel);
  }
}
