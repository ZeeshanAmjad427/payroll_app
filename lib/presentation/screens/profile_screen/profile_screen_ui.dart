import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/top_left_gradient_color.dart';
import 'package:payroll/presentation/screens/manager_profile_screen/manager_profile_screen_ui.dart';
import 'package:payroll/presentation/screens/profile_screen/widgets/input_filed_component.dart';
import 'package:payroll/presentation/screens/settings_screen/settings_screen_ui.dart';

import '../attendance_log_screen/attendance_log_screen_ui.dart';
import '../home_screen/home_screen_ui/home_screen_ui.dart';

class ProfileScreenUi extends StatefulWidget {
  const ProfileScreenUi({super.key});

  @override
  State<ProfileScreenUi> createState() => _ProfileScreenUiState();
}

class _ProfileScreenUiState extends State<ProfileScreenUi> {
  // Controllers for each text field
  final TextEditingController employeeIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController maritalStatusController = TextEditingController();
  final TextEditingController organizationController = TextEditingController();
  final TextEditingController managerController = TextEditingController();
  final TextEditingController employmentTypeController = TextEditingController();
  final TextEditingController joiningDateController = TextEditingController();


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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: const Center(
                      child: Text(
                        'My Profile',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
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
              shadowColor: Colors.black.withOpacity(0.1),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(0), // Border width
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xff008B8B),
                              width: 3.0,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('assets/profile.jpg'),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff008B8B),
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(4),
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Mustafa Tayabani',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Sr. UI/UX Designer',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24),

                    // Personal Info Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Text(
                            'Personal Info',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                    Divider(
                      color: Colors.grey.withOpacity(0.2),
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
                    InputFiledComponent(
                      label: 'Date of Birth',
                      keyboardType: TextInputType.datetime,
                      readOnly: true,
                      controller: dobController,
                      onTap: () {
                        // Optional: Show date picker
                      },
                      hintText: '15 March 2000',
                    ),
                    InputFiledComponent(
                      label: 'Nationality',
                      controller: nationalityController,
                      hintText: 'Pakistani',
                    ),
                    InputFiledComponent(
                      label: 'Marital Status',
                      controller: maritalStatusController,
                      hintText: 'Single',
                    ),
                    SizedBox(height: 4,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Text(
                            'Organization Info',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4,),
                    Divider(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    InputFiledComponent(
                      label: 'Organization',
                      controller: maritalStatusController,
                      hintText: 'Web & App',
                    ),
                    InputFiledComponent(
                      label: 'Manager',
                      controller: managerController,
                      hintText: 'Shayan Sherwani',
                      trailingText: 'View Profile',
                      onTrailingTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ManagerProfileScreenUi()));
                      },
                    ),


                    InputFiledComponent(
                      label: 'Employment Type',
                      controller: maritalStatusController,
                      hintText: 'Full Time',
                    ),
                    InputFiledComponent(
                      label: 'Joining Date',
                      controller: maritalStatusController,
                      hintText: '10 December 2024',
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

        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar_today), label: 'Attendance'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.square_stack_3d_up), label: 'Settings'),
        ],
      ),
    );
  }
}
