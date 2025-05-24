import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll/core/utils/snack_bar_util.dart';
import 'package:payroll/presentation/screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/home_screen_ui.dart';
import 'package:payroll/presentation/screens/login_screen/login_screen_ui/widgets/email_input_field.dart';
import 'package:payroll/presentation/screens/login_screen/login_screen_ui/widgets/password_input_field.dart';
import 'package:payroll/presentation/screens/login_screen/login_screen_ui/widgets/login_button.dart';
import 'package:payroll/core/utils/corner_gradient_painter.dart';
import 'package:payroll/presentation/screens/otp_screen/otp_screen_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

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
            // height: screenHeight * 0.87.h,
            width: double.infinity,
            padding:  EdgeInsets.all(20.0.w),
            child: Card(
              shadowColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding:  EdgeInsets.all(16.0.w),
                child: BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.loginStatus == LoginStatus.failure) {
                      SnackBarUtil.showSnackBar(context, state.message);
                    } else if (state.loginStatus == LoginStatus.success) {
                      SnackBarUtil.showSnackBar(context, state.message);
                      bool isTotp = state.isTotp;
                      if(!isTotp){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const BottomNavbarScreen()),
                        );
                      }
                      else{
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const OtpScreenUi()),
                        );
                      }

                    }
                  },
                  builder: (context, state) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/login.png',
                              height: screenHeight * 0.2.h,
                              fit: BoxFit.contain,
                            ),
                          ),
                           SizedBox(height: 15.h),
                           Text(
                            'Get Started now',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff008B8B),
                            ),
                          ),
                           SizedBox(height: 5.h),
                           Text(
                            'Login to explore our app',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                           SizedBox(height: 15.h),
                          InputField(
                            title: 'Email',
                            hintText: 'Enter Your Email',
                            textEditingControllerValue: email,
                          ),
                           SizedBox(height: 15.h),
                          InputField(
                            title: 'Password',
                            hintText: 'Enter Your Password',
                            textEditingControllerValue: password,
                          ),
                           SizedBox(height: 5.h),
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
                                   Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child:  Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: Color(0xff008B8B),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                           SizedBox(height: 5.h),
                          SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: LoginButton(
                              text: state.isLoading ? 'Log In...' : 'Log In',
                              onPressed: state.isLoading
                                  ? null
                                  : () {
                                if(email.text.isEmpty){
                                  SnackBarUtil.showSnackBar(context, "Please Enter Your Email");
                                  return;
                                }
                                if(password.text.isEmpty){
                                  SnackBarUtil.showSnackBar(context, "Please Enter Your Password");
                                  return;
                                }
                                context.read<LoginBloc>().add(LoginSubmitted(
                                  email: email.text,
                                  password: password.text,
                                ));
                              },
                            ),
                          ),
                           SizedBox(height: 5.h),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child:  Text(
                                    "Contact Us",
                                    style: TextStyle(
                                      color: Color(0xff008B8B),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

              ),
            ),
          ),
        ),
      ),
    );
  }
}
