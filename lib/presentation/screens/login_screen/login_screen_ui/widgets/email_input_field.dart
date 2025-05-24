import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textEditingControllerValue;

  const InputField({
    super.key,
    required this.title,
    required this.hintText,
    required this.textEditingControllerValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:  TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
         SizedBox(height: 8.h),
        TextField(
          controller: textEditingControllerValue,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            isDense: true,
            contentPadding:  EdgeInsets.symmetric(
              vertical: 16.w,
              horizontal: 16.w,
            ),
            hintText: hintText,
            hintStyle:  TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xff008B8B)),
            ),
          ),
        ),
      ],
    );
  }
}
