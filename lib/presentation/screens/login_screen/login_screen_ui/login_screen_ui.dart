import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/home_screen_ui.dart';
import 'package:payroll/presentation/screens/login_screen/login_screen_ui/widgets/email_input_field.dart';
import 'package:payroll/presentation/screens/login_screen/login_screen_ui/widgets/password_input_field.dart';
import 'package:payroll/presentation/screens/login_screen/login_screen_ui/widgets/login_button.dart';
import 'package:payroll/core/utils/corner_gradient_painter.dart';

import '../login_bloc/login_bloc.dart';
import '../login_bloc/login_event.dart';
import '../login_bloc/login_state.dart';

class LoginScreenUi extends StatefulWidget {
  const LoginScreenUi({super.key});

  @override
  State<LoginScreenUi> createState() => _LoginScreenUiState();
}

class _LoginScreenUiState extends State<LoginScreenUi> {
  bool _rememberMe = false;
  bool obscurePassword = true;

  void _onToggleVisibility() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: CustomPaint(
        painter: CornerGradientPainter(),
        child: Center(
          child: Container(
            height: screenHeight * 0.87,
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shadowColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.loginStatus == LoginStatus.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    } else if (state.loginStatus == LoginStatus.success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HomeScreenUi(),
                        ),
                      );
                    }
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/login.png',
                            height: screenHeight * 0.2,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Get Started now',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff008B8B),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Login to explore our app',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 15),

                        BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (previous, current) =>
                          previous.email != current.email,
                          builder: (context, state) {
                            return EmailInputField(
                              initialValue: state.email,
                              onChanged: (email) => context.read<LoginBloc>().add(EmailChanged(email: email)),
                            );
                          },
                        ),

                        const SizedBox(height: 15),

                        BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (previous, current) =>
                          previous.password != current.password,
                          builder: (context, state) {
                            return PasswordInputField(
                              obscurePassword: obscurePassword,
                              onToggleVisibility: _onToggleVisibility,
                              onChanged: (password) => context.read<LoginBloc>().add(PasswordChanged(password: password)),
                            );
                          },
                        ),

                        const SizedBox(height: 5),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  activeColor: const Color(0xff008B8B),
                                  side: const BorderSide(color: Colors.grey),
                                  value: _rememberMe,
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMe = value!;
                                    });
                                  },
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                                ),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: Color(0xff008B8B),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 5),

                        BlocBuilder<LoginBloc, LoginState>(
                          buildWhen: (previous, current) =>
                          previous.isLoading != current.isLoading,
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: LoginButton(
                                text: state.isLoading ? 'Log In...' : 'Log In',
                                onPressed: state.isLoading
                                    ? null
                                    : () {
                                  context.read<LoginBloc>().add(LoginSubmitted());
                                },
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 5),

                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    color: Color(0xff008B8B),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
