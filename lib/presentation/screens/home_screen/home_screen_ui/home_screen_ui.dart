import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:payroll/data/datasources/attendance/attendance_remote_data_source.dart';
import 'package:payroll/domain/usecases/attendance_usecase.dart';
import 'package:payroll/presentation/screens/attendance_log_screen/attendance_log_screen_ui.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/attendance_bloc/attendance_event.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/calendar_scroller.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/info_container.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/profile_header.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/top_left_gradient_color.dart';
import 'package:payroll/presentation/screens/profile_screen/profile_screen_ui.dart';
import 'package:payroll/presentation/screens/settings_screen/settings_screen_ui.dart';
import 'package:payroll/services/token_manager.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../../../../data/models/location_model/attendance_model.dart';
import '../../../../data/repositories/attendance_repository_impl.dart';
import '../../../../domain/repositories/attendance_repository.dart';
import 'attendance_bloc/attendance_bloc.dart';

class HomeScreenUi extends StatefulWidget {
  const HomeScreenUi({super.key});

  @override
  State<HomeScreenUi> createState() => _HomeScreenUiState();
}

class _HomeScreenUiState extends State<HomeScreenUi> {
  late List<DateTime> _days;
  late ScrollController _scrollController;
  String? _currentAddress;
  bool _isFetchingAddress = true;
  bool _isCheckedIn = false;
  DateTime? _checkInTime;
  DateTime? _checkOutTime;
  late Timer _timer;
  DateTime _now = DateTime.now();
  String _attendanceStatus = '';
  int _selectedIndex = 0;
  bool _isWorkFromHome = false;
  String? employeeId = "";

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final startDate = DateTime(now.year, now.month, 1);
    final endDate = DateTime(now.year, now.month + 1, 0);
    _days = List.generate(endDate.day, (index) => DateTime(startDate.year, startDate.month, index + 1));
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
      _fetchLocation();
    });
    _startTimer();
    printSavedTokens();
  }

  void printSavedTokens() async {
    employeeId = await TokenManager.getEmployeeId();
    final accessToken = await TokenManager.getAccessToken();
    final refreshToken = await TokenManager.getRefreshToken();

    print("User Id: $employeeId");
    print("Access Token : $accessToken");
    print("Refresh Token : $refreshToken");
  }


  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToToday() {
    final today = DateTime.now();
    final index = _days.indexWhere((day) => day.day == today.day && day.month == today.month && day.year == today.year);
    if (index != -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(index * (MediaQuery.of(context).size.width * 0.22 + 12));
      });
    }
  }

  Future<void> _fetchLocation() async {
    setState(() {
      _isFetchingAddress = true;
    });

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentAddress = "Location services are disabled.";
        _isFetchingAddress = false;
      });
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentAddress = "Location permission denied.";
          _isFetchingAddress = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentAddress = "Location permission permanently denied.";
        _isFetchingAddress = false;
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address =
            "${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.country}, ${place.postalCode}";
        setState(() {
          _currentAddress = address;
          _isFetchingAddress = false;
        });
      } else {
        setState(() {
          _currentAddress = "Address not found.";
          _isFetchingAddress = false;
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = "Failed to get location.";
        _isFetchingAddress = false;
      });
    }
  }

  // bool get _isLocationValid {
  //   return _currentAddress != null &&
  //       _currentAddress!.toLowerCase().contains("business enclave") &&
  //       _currentAddress!.toLowerCase().contains("defence housing authority");
  // }

  String _getCheckInStatus(DateTime time) {
    final cutoff = DateTime(time.year, time.month, time.day, 10, 0);
    return time.isBefore(cutoff) ? 'On Time' : 'Late';
  }

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
            CustomPaint(painter: TopLeftGradientPainter(), child: Container()),
            const ProfileHeader(),
            CalendarScroller(days: _days, scrollController: _scrollController),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.32,
              left: 0,
              right: 0,
              bottom: 0,
              child: Card(
                color: Colors.white,
                shadowColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Last Attendance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: InfoContainer(
                              icon: Image.asset('assets/check_in.png'),
                              title: 'Check In',
                              data: _checkInTime != null
                                  ? DateFormat('hh:mm:ss a').format(_checkInTime!)
                                  : DateFormat('hh:mm:ss a').format(_now),
                              text: _checkInTime != null ? _attendanceStatus : 'Not Yet',
                            ),
                          ),
                          Expanded(
                            child: InfoContainer(
                              icon: Image.asset('assets/check_out.png'),
                              title: 'Check Out',
                              data: _checkOutTime != null
                                  ? DateFormat('hh:mm:ss a').format(_checkOutTime!)
                                  : DateFormat('hh:mm:ss a').format(_now),
                              text: _checkOutTime != null ? 'Checked Out' : 'Not Yet',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: InfoContainer(
                              icon: const Icon(Icons.directions_run_sharp, size: 22, color: Color(0xff008B8B)),
                              title: 'Total Lates',
                              data: '02',
                              text: 'Late Check In',
                            ),
                          ),
                          Expanded(
                            child: InfoContainer(
                              icon: const Icon(Icons.calendar_today_outlined, size: 22, color: Color(0xff008B8B)),
                              title: 'Total Days',
                              data: '31',
                              text: 'Working Days',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text('Current Location', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(4),
                                    color: const Color(0xff008B8B).withOpacity(0.2),
                                  ),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      if (_isFetchingAddress)
                                        const CircularProgressIndicator(
                                          strokeWidth: 3,
                                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff008B8B)),
                                        ),
                                      const Icon(Icons.location_on_outlined, color: Color(0xff008B8B), size: 28),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    _currentAddress ?? "Address not available",
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _fetchLocation,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff008B8B),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Fetch Again', style: TextStyle(color: Colors.white)),
                                    SizedBox(width: 8),
                                    Icon(CupertinoIcons.arrow_2_circlepath, color: Colors.white, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(0, 2),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    activeColor: const Color(0xff008B8B),
                                    side: BorderSide(color: Colors.grey.withOpacity(0.5)),
                                    value: _isWorkFromHome,
                                    onChanged: (value) {
                                      setState(() {
                                        _isWorkFromHome = value ?? false;
                                      });
                                    },
                                  ),
                                  const Text(
                                    'Work From Home?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: const Color(0xff008B8B).withOpacity(0.2),
                                      ),
                                      child: Image.asset('assets/home.png'),
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.grey.withOpacity(0.2),
                                thickness: 1,
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: SlideAction(
                                  enabled: !_isFetchingAddress &&
                                      !(_checkInTime != null && _checkOutTime != null),
                                  outerColor: _isCheckedIn ? Colors.red : const Color(0xff008B8B),
                                  innerColor: Colors.white,
                                  elevation: 2,
                                  borderRadius: 6,
                                  height: 62,
                                  sliderButtonIcon: Icon(
                                    Icons.horizontal_distribute_rounded,
                                    color: _isCheckedIn ? Colors.red : const Color(0xff008B8B),
                                  ),
                                  text: _isCheckedIn ? 'Swipe to Check Out' : 'Swipe to Check In',
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  onSubmit: () async {
                                    final now = DateTime.now();

                                    if (!_isCheckedIn) {
                                      // This block runs on Check-In swipe

                                      setState(() {
                                        _checkInTime = now;
                                        _attendanceStatus = _getCheckInStatus(now);
                                        _isCheckedIn = true;
                                      });


                                      final attendance = AttendanceModel(
                                        employeeId: employeeId ?? "",
                                        date: now,
                                        status: _attendanceStatus,
                                        timeIn: now,
                                        locationInId: _currentAddress.toString(),
                                        hoursWorked: 0,
                                      );

                                      print(jsonEncode(attendance));
                                      // Dispatch BLoC event
                                      context.read<AttendanceBloc>().add(
                                        MarkAttendanceEvent(attendanceModel: attendance),
                                      );
                                    } else {


                                      setState(() {
                                        _checkOutTime = now;
                                        _isCheckedIn = false;
                                      });

                                      // Optional: You can dispatch a CheckOut event if you have that implemented
                                    }
                                  },
                                )

                              ),
                              const SizedBox(height: 8),
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
                _selectedIndex == 0
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
