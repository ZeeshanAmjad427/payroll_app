import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // nullable now

  const LoginButton({
    required this.text,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: onPressed, // this accepts null now
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff008B8B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        child: Text(
          text,
          style:  TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
