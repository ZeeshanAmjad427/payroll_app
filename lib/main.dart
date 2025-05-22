import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll/data/datasources/totp/totp_remote_data_source.dart';
import 'package:payroll/data/repositories/auth_repository_impl.dart';
import 'package:payroll/data/repositories/totp_repository_impl.dart';
import 'package:payroll/dio_client/dio_client.dart';
import 'package:payroll/domain/repositories/totp_repository.dart';
import 'package:payroll/domain/usecases/totp_usecase.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/attendance_bloc/attendance_bloc.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/home_screen_ui.dart';
import 'package:payroll/presentation/screens/login_screen/login_bloc/login_bloc.dart';
import 'package:payroll/presentation/screens/otp_screen/otp_screen_ui.dart';
import 'package:payroll/presentation/screens/profile_screen/profile_screen_ui.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_bloc.dart';
import 'package:payroll/presentation/screens/splash_screen/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data/datasources/attendance/attendance_remote_data_source.dart';
import 'data/datasources/auth/LoginRemoteDataSource.dart';
import 'data/repositories/attendance_repository_impl.dart';
import 'domain/usecases/attendance_usecase.dart';

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

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (_) => LoginBloc(authRepository: authRepository),
            ),
            BlocProvider(
              create: (context) => AttendanceBloc(
                AttendanceUseCase(
                  AttendanceRepositoryImpl(AttendanceRemoteDataSource()),
                ),
              ),
            ),
            BlocProvider(
              create: (context) => TotpBloc(
                getTotpUseCase: GetTotpUseCase(
                  repository: TotpRepositoryImpl(
                    remoteDataSource: TotpRemoteDataSourceImpl(dioClient: dioClient),
                  ),
                ),
              ),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.notoSansTextTheme().apply(
                bodyColor: Colors.black,
                displayColor: Colors.white,
              ),
            ),
            home: child,
          ),
        );
      },
      child: const SplashScreenUi(),
    );
  }
}