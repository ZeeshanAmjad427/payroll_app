import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll/presentation/screens/attendance_log_screen/attendance_log_screen_ui.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/home_screen_ui.dart';
import 'package:payroll/presentation/screens/manager_profile_screen/manager_profile_screen_ui.dart';
import 'package:payroll/presentation/screens/profile_screen/profile_screen_ui.dart';
import 'package:payroll/presentation/screens/settings_screen/settings_screen_ui.dart';

class BottomNavbarScreen extends StatefulWidget {
  final int selectedIndex;
  final Widget? overrideScreen;
  const BottomNavbarScreen({super.key,this.selectedIndex = 0,this.overrideScreen});

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {
  late int _selectedIndex;
  String? id;
  static const List<Widget> _pages = <Widget>[
    HomeScreenUi(),
    AttendanceLogScreenUi(),
    ProfileScreenUi(),
    SettingsScreenUi(),
    ManagerProfileScreenUi(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Expanded(
            child: widget.overrideScreen ?? _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff008B8B),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,

        selectedLabelStyle:  TextStyle(color: Colors.white, fontSize: 10.r),
        unselectedLabelStyle:  TextStyle(color: Colors.white, fontSize: 10.r),

        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.white),

        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 0
                  ? 'assets/home_selected.png'
                  : 'assets/home_unselected.png',
              width: 24.w,
              height: 24.h,
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 1
                  ? 'assets/calendar_selected.png'
                  : 'assets/calendar_unselected.png',
              width: 24.w,
              height: 24.h,
            ),
            label: 'Attendance',
          ),

          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 2
                  ? 'assets/profile_selected.png'
                  : 'assets/profile_unselected.png',
              width: 24.w,
              height: 24.h,
            ),
            label: 'Profile',
          ),

          BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_stack_3d_up), label: 'Settings'),

        ],
      ),
    );
  }
}
