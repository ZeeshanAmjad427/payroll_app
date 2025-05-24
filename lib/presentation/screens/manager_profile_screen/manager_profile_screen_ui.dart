import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll/core/utils/header_util.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/top_left_gradient_color.dart';
import 'package:payroll/presentation/screens/profile_screen/widgets/input_filed_component.dart';
import 'package:payroll/presentation/screens/settings_screen/settings_screen_ui.dart';

import '../attendance_log_screen/attendance_log_screen_ui.dart';
import '../home_screen/home_screen_ui/home_screen_ui.dart';
import '../profile_screen/profile_screen_ui.dart';

class ManagerProfileScreenUi extends StatefulWidget {
  const ManagerProfileScreenUi({super.key});

  @override
  State<ManagerProfileScreenUi> createState() => _ManagerProfileScreenUiState();
}

class _ManagerProfileScreenUiState extends State<ManagerProfileScreenUi> {
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController managerController = TextEditingController();
  final TextEditingController employmentTypeController = TextEditingController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreenUi()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceLogScreenUi()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreenUi()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreenUi()));
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
          HeaderUtil(title: "Manager Profile"),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: Card(
              color: Colors.white,
              shadowColor: Colors.black.withOpacity(0.1),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: SingleChildScrollView(
                padding:  EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(height: 16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              padding:  EdgeInsets.all(0.w),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xff008B8B),
                                  width: 3.0,
                                ),
                              ),
                              child:  CircleAvatar(
                                radius: 40.r,
                                backgroundImage: AssetImage('assets/profile.jpg'),
                              ),
                            ),
                            Positioned(
                              bottom: 4.h,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xff008B8B),
                                  shape: BoxShape.circle,
                                ),
                                padding:  EdgeInsets.all(4.w),
                                child:  Icon(
                                  Icons.edit,
                                  size: 16.r,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                         SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  [
                            Text(
                              'Shayan Sherwani',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              'Senior Project Manager',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                     SizedBox(height: 24.h),

                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Text(
                        'Personal Info',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                     SizedBox(height: 4.h),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h,),
                      child: DottedLine(
                        dashLength: 3.0,
                        dashGapLength: 5.0,
                        lineThickness: 1.0,
                        dashColor: Colors.grey.withOpacity(0.4),
                      ),
                    ),

                    InputFiledComponent(
                      label: 'Employee ID',
                      controller: employeeIdController,
                      hintText: 'EMP-10023',
                    ),
                    InputFiledComponent(
                      label: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      hintText: 'mustafa.ali@qbsco.net',
                    ),
                    InputFiledComponent(
                      label: 'Contact No',
                      keyboardType: TextInputType.phone,
                      controller: contactNoController,
                      hintText: '+923211231231',
                    ),

                     SizedBox(height: 4.h),
                     Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                      child: Text(
                        'Organization Info',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h,),
                      child: DottedLine(
                        dashLength: 3.0,
                        dashGapLength: 5.0,
                        lineThickness: 1.0,
                        dashColor: Colors.grey.withOpacity(0.4),
                      ),
                    ),

                    InputFiledComponent(
                      label: 'Organization',
                      controller: organizationController,
                      hintText: 'Web & App',
                    ),
                    InputFiledComponent(
                      label: 'Manager',
                      controller: managerController,
                      hintText: 'Faraz Quddusi',
                      trailingText: 'View Profile',
                      onTrailingTap: () {
                        // Handle view profile navigation here
                      },
                    ),
                    InputFiledComponent(
                      label: 'Employment Type',
                      controller: employmentTypeController,
                      hintText: 'Full Time',
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
      //         _selectedIndex == 0
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
