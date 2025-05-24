import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.10.h,
      left: 20.w,
      right: 20.w,
      child: Row(
        children: [
          Container(
            padding:  EdgeInsets.all(0.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff008B8B),
                width: 3.w,
              ),
            ),
            child:  CircleAvatar(
              radius: 25.r,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
          ),
           SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'Mustafa Tayabani',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Sr. UI/UX Designer',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 35.h,
              width: 35.w,
              decoration: BoxDecoration(
              shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(4.r),
    color: const Color(0xff008B8B).withOpacity(0.2),
    ),
              child: Icon(CupertinoIcons.search,size: 32.r,color: Color(0xff008B8B),))
        ],
      ),
    );
  }
}
