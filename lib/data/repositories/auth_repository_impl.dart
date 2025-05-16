import 'dart:async';
import '../../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login({required String email, required String password}) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay

    // Simulated check
    if (email != '123' || password != '123') {
      throw Exception('Invalid email or password');
    }
  }
}
