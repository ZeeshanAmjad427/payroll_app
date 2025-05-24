import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payroll/core/utils/corner_gradient_painter.dart';
import 'package:payroll/core/utils/snack_bar_util.dart';
import 'package:payroll/data/models/totp_model/verify_totp_request_model.dart';
import 'package:payroll/presentation/screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/home_screen_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_bloc.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_state.dart';
import 'package:payroll/services/token_manager.dart';

import '../profile_screen/totp_bloc/totp_event.dart';
class OtpScreenUi extends StatefulWidget {
  const OtpScreenUi({super.key});

  @override
  State<OtpScreenUi> createState() => _OtpScreenUiState();
}

class _OtpScreenUiState extends State<OtpScreenUi> {
  final List<TextEditingController> _controllers =
  List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _focusNodes[index].unfocus();
      }
    }
    setState(() {});
  }

  String _getOtp() {
    return _controllers.map((controller) => controller.text).join();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TotpBloc, TotpState>(
      listener: (context, state) async {
        if (state.loginStatus == TotpStatus.success) {
          final isVerified = state.verifyTotpResponseModel?.data?.isVerified ?? false;

          if (isVerified) {
            SnackBarUtil.showSnackBar(context, state.message);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const BottomNavbarScreen()),
            );
          } else {
            SnackBarUtil.showSnackBar(context, "OTP verification failed. Please try again.");
          }
        } else if (state.loginStatus == TotpStatus.failure) {
          SnackBarUtil.showSnackBar(context, state.message);
        }
      },

      builder: (context, state) {
    return Scaffold(
      body: CustomPaint(
        painter: CornerGradientPainter(),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            margin:  EdgeInsets.symmetric(horizontal: 24.w),
            child: Padding(
              padding:  EdgeInsets.all(20.0.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff008B8B),
                      ),
                    ),
                  ),
                   SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      text: TextSpan(
                        text: 'Enter the 6 digit code sent to ',
                        style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                        children: [
                          TextSpan(
                            text: 'LockKeyz App.',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                   SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      bool hasValue = _controllers[index].text.isNotEmpty;
                      return SizedBox(
                        height: 40.h,
                        width: 40.w,
                        child: Center(
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: hasValue ? Colors.orange : Colors.grey,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: hasValue ? Colors.orange : Colors.grey,
                                  width: 1,
                                ),
                              ),
                            ),
                            onChanged: (value) => _onChanged(value, index),
                          ),
                        ),
                      );
                    }),
                  ),
                   SizedBox(height: 24.h),
                  SizedBox(
                    height: 50.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async{
                        final otp = _getOtp();

                        // Check if OTP is 6 digits and all numeric
                        final isValid = otp.length == 6 && RegExp(r'^\d{6}$').hasMatch(otp);

                        if (!isValid) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a valid 6-digit OTP.'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        // Proceed if OTP is valid
                        print("OTP is valid: $otp");
                        String? secretKey = await TokenManager.getSecretKey();
                        if(secretKey != null && secretKey.isNotEmpty){
                          context.read<TotpBloc>().add(VerifyTotpEvent(verifyTotpRequestModel: VerifyTotpRequestModel(secetKey: secretKey, totpCode: otp, timeLimitInSec: 30, numOfDigits: 6)));
                        }

                        // For now navigate or dispatch Bloc event
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenUi()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff008B8B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child:  Text(
                        'Log In',
                        style: TextStyle(color: Colors.white, fontSize: 14.sp),
                      ),
                    ),
                  ),
                   SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        "Didn't get OTP? ",
                        style: TextStyle(fontSize: 14.sp, color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Resend OTP action
                        },
                        child:  Text(
                          "Resend OTP",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xff008B8B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
