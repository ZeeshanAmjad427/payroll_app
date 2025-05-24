import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoContainer extends StatelessWidget {
  final Widget icon;
  final String title;
  final String data;
  final String text;

  const InfoContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.data,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40.w,
      margin:  EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 30.h,
                  width: 30.w,
                  padding:  EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: const Color(0xff008B8B).withOpacity(0.2),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4.r)
                  ),
                  child: icon,
                ),
                 SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    title,
                    style:  TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
             SizedBox(height: 6.h),
            Text(
              data,
              style:  TextStyle(fontSize: 20.sp,
                  color: Color(0xff008B8B)),
            ),
             SizedBox(height: 6.h),
            Text(
              text,
              style:  TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
