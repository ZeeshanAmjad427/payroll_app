import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll/data/repositories/auth_repository_impl.dart';
import 'package:payroll/dio_client/dio_client.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/home_screen_ui.dart';
import 'package:payroll/presentation/screens/login_screen/login_bloc/login_bloc.dart';
import 'package:payroll/presentation/screens/otp_screen/otp_screen_ui.dart';
import 'package:payroll/presentation/screens/profile_screen/profile_screen_ui.dart';
import 'package:payroll/presentation/screens/splash_screen/splash_screen_ui.dart';

import 'data/datasources/auth/LoginRemoteDataSource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final dioClient = DioClient();
    final loginRemoteDataSource = LoginRemoteDataSource(dioClient);
    final authRepository = AuthRepositoryImpl(loginRemoteDataSource);

    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(authRepository: authRepository),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreenUi(),
      ),
    );
  }
}
