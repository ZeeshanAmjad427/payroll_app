import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/top_left_gradient_color.dart';

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
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            left: 0,
            right: 0,
            bottom: 0,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Settings
                    Row(
                      children: const [
                        Icon(Icons.settings, color: Color(0xff008B8B), size: 18),
                        SizedBox(width: 8),
                        Text(
                          'App Settings',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Dark Mode',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),),
                        CupertinoSwitch(
                          value: isDarkMode,
                          activeTrackColor: Color(0xff008B8B),
                          onChanged: (val) {
                            setState(() => isDarkMode = val);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('App Language',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Check-In Reminder',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                        CupertinoSwitch(
                          value: isCheckInReminder,
                          activeTrackColor: Color(0xff008B8B),
                          onChanged: (val) {
                            setState(() => isCheckInReminder = val);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Help & Terms
                    Row(
                      children: const [
                        Icon(Icons.verified_user, color: Color(0xff008B8B), size: 18),
                        SizedBox(width: 8),
                        Text(
                          'Help & Terms of Use',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
                    const Divider(height: 20),
                    const Text('Privacy Policy',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                    const SizedBox(height: 12),
                    const Text('Terms of User',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                    const Spacer(),
                    // Logout Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Logout logic here
                        },
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text('Log Out', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff008B8B),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,

        selectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 10),
        unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 10),

        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.white),

        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 1
                  ? 'assets/home_selected.png'
                  : 'assets/home_unselected.png',
              width: 24,
              height: 24,
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 1
                  ? 'assets/calendar_selected.png'
                  : 'assets/calendar_unselected.png',
              width: 24,
              height: 24,
            ),
            label: 'Attendance',
          ),

          BottomNavigationBarItem(
            icon: Image.asset(
              _selectedIndex == 1
                  ? 'assets/profile_selected.png'
                  : 'assets/profile_unselected.png',
              width: 24,
              height: 24,
            ),
            label: 'Profile',
          ),

          BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_stack_3d_up), label: 'Settings'),
        ],
      ),

    );
  }
}
