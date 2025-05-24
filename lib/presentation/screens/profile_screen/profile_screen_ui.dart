import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:payroll/core/utils/header_util.dart';
import 'package:payroll/core/utils/snack_bar_util.dart';
import 'package:payroll/data/models/totp_model/on_totp_request_model.dart';
import 'package:payroll/presentation/screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/top_left_gradient_color.dart';
import 'package:payroll/presentation/screens/manager_profile_screen/manager_profile_screen_ui.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_bloc.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_event.dart';
import 'package:payroll/presentation/screens/profile_screen/totp_bloc/totp_state.dart';
import 'package:payroll/presentation/screens/profile_screen/widgets/input_filed_component.dart';
import 'package:payroll/presentation/screens/settings_screen/settings_screen_ui.dart';
import 'package:payroll/services/token_manager.dart';
import '../attendance_log_screen/attendance_log_screen_ui.dart';
import '../home_screen/home_screen_ui/home_screen_ui.dart';

class ProfileScreenUi extends StatefulWidget {
  const ProfileScreenUi({super.key});

  @override
  State<ProfileScreenUi> createState() => _ProfileScreenUiState();
}

class _ProfileScreenUiState extends State<ProfileScreenUi> {

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
  bool _is2FAEnabled = false;
  String? employeeId = "";
  String? secretKey = "";


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
  void initState() {
    super.initState();
    isTotpEnable();
  }

  Future<void> isTotpEnable() async {
    secretKey = await TokenManager.getSecretKey();
    employeeId = await TokenManager.getEmployeeId();
    bool? isTotp = await TokenManager.getIsTotp();
    print('TOTP : $isTotp');

    if (!mounted) return;

    // setState(() {
    //   _is2FAEnabled = isTotp ?? false;
    // });

    if (!(isTotp ?? false)) {
      context.read<TotpBloc>().add(GetTotpEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TotpBloc, TotpState>(
  listener: (context, state) {
    if (state.loginStatus == TotpStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.isTotp
              ? '2FA Enabled Successfully'
              : '2FA Disabled Successfully'),
        ),
      );
      return;
    }
    if(state.loginStatus == TotpStatus.failure){
      SnackBarUtil.showSnackBar(context, state.message);
    }
  },
  builder: (context, state) {
    final stateValue = context.read<TotpBloc>().state;
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: TopLeftGradientPainter(),
            child: Container(),
          ),
          HeaderUtil(title: "My Profile"),
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
                  children: [
                    SizedBox(height: 16.h),
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
                            radius: 50.r,
                            backgroundImage: AssetImage('assets/profile.jpg'),
                          ),
                        ),
                        Positioned(
                          bottom: 10.h,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff008B8B),
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(4.w),
                            child: Icon(
                              Icons.edit,
                              size: 18.r,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Mustafa Tayabani',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Sr. UI/UX Designer',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Personal Info Section
                    Row(
                      children: [
                        Text(
                          'Personal Info',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text(
                          'Organization Info',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h),
                      child: DottedLine(
                        dashLength: 3.0,
                        dashGapLength: 5.0,
                        lineThickness: 1.0,
                        dashColor: Colors.grey.withOpacity(0.4),
                      ),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavbarScreen(
                              overrideScreen: const ManagerProfileScreenUi(),
                            ),
                          ),
                        );
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
                    Padding(
                      padding:  EdgeInsets.only(top: 16.0.h),
                      child: Card(
                        color: Colors.white,
                        shadowColor: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 50.h,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:  EdgeInsets.only(left: 8.0.w),
                                    child: Text(
                                      'Enable 2FA',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0.w),
                                    child: CupertinoSwitch(
                                      activeTrackColor: const Color(0xff008B8B),
                                      value: state.isTotp,
                                      onChanged: (bool value) {
                                        print("VAL: ${state.isTotp}");
                                        if (value) {
                                          // Enable 2FA
                                          context.read<TotpBloc>().add(
                                            On2faEvent(
                                              onTotpRequestModel: OnTotpRequestModel(
                                                userId: employeeId ?? "",
                                                secretKey: secretKey ?? "",
                                                isTotp: true,
                                              ),
                                            ),
                                          );
                                        } else {
                                          // Disable 2FA
                                          context.read<TotpBloc>().add(
                                            OnRemove2faEvent(
                                              userId: employeeId ?? "",
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),

                            if (state.isTotp) ...[
                               SizedBox(height: 6.h),
                              Padding(
                                padding:  EdgeInsets.only(left: 8.0.w),
                                child:  Text(
                                  'Scan this QR code in-app to verify a account',
                                  style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w400),
                                ),
                              ),
                               SizedBox(height: 12.h),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h,),
                                child: DottedLine(
                                  dashLength: 3.0,
                                  dashGapLength: 5.0,
                                  lineThickness: 1.0,
                                  dashColor: Colors.grey.withOpacity(0.4),
                                ),
                              ),
                               SizedBox(height: 12.h),

                              // QR Code Placeholder
                              Center(
                                child: Container(
                                  width: 150.w,
                                  height: 150.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child:  Center(
                                      child: Image.asset('assets/QR.png')
                                  ),
                                ),
                              ),

                               SizedBox(height: 10.h),

                              Row(
                                children: [
                                  Expanded(child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h,),
                                    child: DottedLine(
                                      dashLength: 3.0,
                                      dashGapLength: 5.0,
                                      lineThickness: 1.0,
                                      dashColor: Colors.grey.withOpacity(0.4),
                                    ),
                                  ),
                                  ),
                                   Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                    child: Text("or enter the security key manually", style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold)),
                                  ),
                                  Expanded(child: Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 2.w,vertical: 4.h,),
                                    child: DottedLine(
                                      dashLength: 3.0,
                                      dashGapLength: 5.0,
                                      lineThickness: 1.0,
                                      dashColor: Colors.grey.withOpacity(0.4),
                                    ),
                                  ),),
                                ],
                              ),
                               SizedBox(height: 12.h),


                              Padding(
                                padding:  EdgeInsets.all(8.0.w),
                                child: Container(
                                  padding:  EdgeInsets.symmetric(horizontal: 6.w, vertical: 0.h),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    children: [
                                       Expanded(
                                        child: Text(
                                         secretKey.toString(),
                                          style: TextStyle(fontSize: 14.sp,color: Colors.black),
                                        ),
                                      ),
                                      IconButton(
                                        icon:  Icon(Icons.copy, size: 20.r),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("Copied to clipboard")),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                               SizedBox(height: 16.h),
                              Container(
                                width: double.infinity,
                                padding:  EdgeInsets.symmetric(vertical: 12.h),
                                decoration:  BoxDecoration(
                                  color: Color(0xff008B8B),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12.r),
                                    bottomRight: Radius.circular(12.r),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                     SizedBox(width: 8.w),
                                     Text(
                                      'Trusted By LockKeyz',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/lockKeyz.png',
                                      height: 30.h,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
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
      //         _selectedIndex == 0
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
  },
);
  }
}
