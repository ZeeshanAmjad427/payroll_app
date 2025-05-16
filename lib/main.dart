import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll/data/repositories/auth_repository_impl.dart';
import 'package:payroll/domain/repositories/auth_repository.dart';
import 'package:payroll/presentation/screens/login_screen/login_bloc/login_bloc.dart';

import 'package:payroll/presentation/screens/splash_screen/splash_screen_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthRepository>(
      create: (_) => AuthRepositoryImpl(),
      child: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: SplashScreenUi(),
        ),
      ),
    );
  }
}
