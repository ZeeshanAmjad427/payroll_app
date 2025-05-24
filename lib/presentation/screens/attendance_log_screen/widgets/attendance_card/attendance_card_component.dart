import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class AttendanceCardComponent extends StatelessWidget {
  final DateTime date;
  final String status;
  final String checkInTime;
  final String checkOutTime;
  final String checkInNote;
  final String checkOutNote;
  final String totalHours;
  final String checkInDevice;  
  final String checkOutDevice; 

  const AttendanceCardComponent({
    Key? key,
    required this.date,
    this.status = 'Present',
    this.checkInTime = '09:45 AM',
    this.checkOutTime = '05:30 PM',
    this.checkInNote = 'Late (+15m)',
    this.checkOutNote = 'Early (-30m)',
    this.totalHours = 'Worked: 8h 28m',
    this.checkInDevice = 'mobile',
    this.checkOutDevice = 'mobile',
  }) : super(key: key);

  Color _statusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return const Color(0xff1C8300); // Dark Green
      case 'absent':
        return const Color(0xffD10000); // Red
      case 'weekend':
        return const Color(0xffFF8C00); // Orange
      case 'wfh':
        return const Color(0xff8B4513); // Brown
      default:
        return Colors.black;
    }
  }

  Color _statusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return const Color(0xffE6FFE6); // Light Green
      case 'absent':
        return const Color(0xffFFE6E6); // Light Red
      case 'weekend':
        return const Color(0xffFFF3E0); // Light Orange
      case 'wfh':
        return const Color(0xffF5E3D8); // Light Brown
      default:
        return Colors.grey.shade200;
    }
  }

  Widget _deviceIcon(String device) {
    switch (device.toLowerCase()) {
      case 'mobile':
        return Container(
          height: 25.h,
            width: 25.w,
            decoration: BoxDecoration(
              color: Color(0xff008B8B).withOpacity(0.2),
              borderRadius: BorderRadius.circular(4.r)
            ),
            child:  Icon(Icons.smartphone_rounded, size: 16.r, color: Color(0xff008B8B)));
      case 'laptop':
        return  Icon(Icons.laptop, size: 16.r, color: Color(0xff008B8B));
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      margin:  EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding:  EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 25.h,
                  width: 25.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff008B8B).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child:  Icon(Icons.calendar_today,
                      size: 20.r, color: Color(0xff008B8B)),
                ),
                 SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    DateFormat('MMM dd, yyyy').format(date),
                    style:  TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _statusBackgroundColor(status),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (status.toLowerCase() == 'weekend') ...[
                         Icon(Icons.beach_access, size: 14.r, color: Color(0xffFF8C00)),
                         SizedBox(width: 4.w),
                      ],
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: _statusTextColor(status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 5.h),
              child: DottedLine(
                dashLength: 3.0,
                dashGapLength: 5.0,
                lineThickness: 1.0,
                dashColor: Colors.grey.withOpacity(0.4),
              ),
            ),
             SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _deviceIcon(checkInDevice),
                     SizedBox(width: 6.w),
                     Text('Check-In', style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        checkInNote,
                        style:  TextStyle(
                          fontSize: 12.sp,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                     SizedBox(width: 8.w),
                    Text(checkInTime, style:  TextStyle(fontSize: 14.sp)),
                  ],
                ),
              ],
            ),
             SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _deviceIcon(checkOutDevice),
                     SizedBox(width: 6.w),
                     Text('Check-Out', style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding:  EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xff008B8B).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        checkOutNote,
                        style:  TextStyle(
                          fontSize: 12.sp,
                          color: Color(0xff008B8B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                     SizedBox(width: 8.w),
                    Text(checkOutTime, style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
              ],
            ),
             SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Row(
                  children: [
                    SizedBox(width: 8.w),
                    Text('Total Working Hours', style: TextStyle(fontSize: 14.sp)),
                  ],
                ),
                Text(
                  totalHours,
                  style:  TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff008B8B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
