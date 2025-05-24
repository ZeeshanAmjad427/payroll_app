import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderUtil extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const HeaderUtil({
    Key? key,
    required this.title,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 60.h,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: onBack ?? () => Navigator.pop(context),
              ),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
