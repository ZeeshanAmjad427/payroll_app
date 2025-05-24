import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll/core/utils/header_util.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/top_left_gradient_color.dart';
import 'package:payroll/presentation/screens/login_screen/login_screen_ui/login_screen_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../attendance_log_screen/attendance_log_screen_ui.dart';
import '../home_screen/home_screen_ui/home_screen_ui.dart';
import '../profile_screen/profile_screen_ui.dart';

class SettingsScreenUi extends StatefulWidget {
  const SettingsScreenUi({super.key});

  @override
  State<SettingsScreenUi> createState() => _SettingsScreenUiState();
}

class _SettingsScreenUiState extends State<SettingsScreenUi> {
  bool isDarkMode = false;
  bool isCheckInReminder = false;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreenUi()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AttendanceLogScreenUi()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreenUi()));

        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreenUi()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: TopLeftGradientPainter(),
            child: Container(),
          ),
          HeaderUtil(title: "Settings"),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              elevation: 4,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Settings
                    Row(
                      children:  [
                        Icon(Icons.settings, color: Color(0xff008B8B), size: 18.r),
                        SizedBox(width: 8.w),
                        Text(
                          'App Settings',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h,),
                      child: DottedLine(
                        dashLength: 3.0,
                        dashGapLength: 5.0,
                        lineThickness: 1.0,
                        dashColor: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text('Dark Mode',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400),),
                        CupertinoSwitch(
                          value: isDarkMode,
                          activeTrackColor: Color(0xff008B8B),
                          onChanged: (val) {
                            setState(() => isDarkMode = val);
                          },
                        ),
                      ],
                    ),
                     SizedBox(height: 12.h),
                     Text('App Language',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400)),
                     SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text('Check-In Reminder',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400)),
                        CupertinoSwitch(
                          value: isCheckInReminder,
                          activeTrackColor: Color(0xff008B8B),
                          onChanged: (val) {
                            setState(() => isCheckInReminder = val);
                          },
                        ),
                      ],
                    ),
                     SizedBox(height: 16.h),
                    // Help & Terms
                    Row(
                      children:  [
                        Icon(Icons.verified_user, color: Color(0xff008B8B), size: 18.r),
                        SizedBox(width: 8.w),
                        Text(
                          'Help & Terms of Use',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                      ],
                    ),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 6.h,),
                      child: DottedLine(
                        dashLength: 3.0,
                        dashGapLength: 5.0,
                        lineThickness: 1.0,
                        dashColor: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                     Text('Privacy Policy',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400)),
                     SizedBox(height: 12.h),
                     Text('Terms of User',style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400)),
                    const Spacer(),
                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async{
                          final prefs = await SharedPreferences.getInstance();
                          prefs.clear();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreenUi()));
                        },
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label:  Text('Log Out', style: TextStyle(fontSize:14.sp,color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding:  EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: const Color(0xff008B8B),
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   showUnselectedLabels: true,
      //   type: BottomNavigationBarType.fixed,
      //
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.white,
      //
      //   selectedLabelStyle:  TextStyle(color: Colors.white, fontSize: 10.sp),
      //   unselectedLabelStyle:  TextStyle(color: Colors.white, fontSize: 10.sp),
      //
      //   selectedIconTheme: const IconThemeData(color: Colors.white),
      //   unselectedIconTheme: const IconThemeData(color: Colors.white),
      //
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Image.asset(
      //         _selectedIndex == 1
      //             ? 'assets/home_selected.png'
      //             : 'assets/home_unselected.png',
      //         width: 24,
      //         height: 24,
      //       ),
      //       label: 'Home',
      //     ),
      //
      //     BottomNavigationBarItem(
      //       icon: Image.asset(
      //         _selectedIndex == 1
      //             ? 'assets/calendar_selected.png'
      //             : 'assets/calendar_unselected.png',
      //         width: 24,
      //         height: 24,
      //       ),
      //       label: 'Attendance',
      //     ),
      //
      //     BottomNavigationBarItem(
      //       icon: Image.asset(
      //         _selectedIndex == 1
      //             ? 'assets/profile_selected.png'
      //             : 'assets/profile_unselected.png',
      //         width: 24,
      //         height: 24,
      //       ),
      //       label: 'Profile',
      //     ),
      //
      //     BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_stack_3d_up), label: 'Settings'),
      //   ],
      // ),

    );
  }
}
