import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:payroll/presentation/screens/attendance_log_screen/attendance_log_screen_ui.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/calendar_scroller.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/info_container.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/profile_header.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/top_left_gradient_color.dart';
import 'package:payroll/presentation/screens/profile_screen/profile_screen_ui.dart';
import 'package:payroll/presentation/screens/settings_screen/settings_screen_ui.dart';
import 'package:slide_to_act/slide_to_act.dart';

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
                            icon: const Icon(CupertinoIcons.square_arrow_right, size: 22, color: Color(0xff008B8B)),
                            title: 'Check In',
                            data: _checkInTime != null
                                ? DateFormat('hh:mm:ss a').format(_checkInTime!)
                                : DateFormat('hh:mm:ss a').format(_now),
                            text: _checkInTime != null ? _attendanceStatus : 'Not Yet',
                          ),
                        ),
                        Expanded(
                          child: InfoContainer(
                            icon: const Icon(CupertinoIcons.square_arrow_left, size: 22, color: Color(0xff008B8B)),
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
                            icon: const Icon(CupertinoIcons.home, size: 22, color: Color(0xff008B8B)),
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
                    SlideAction(
                      enabled: !_isFetchingAddress &&
                          // _isLocationValid &&
                          !(_checkInTime != null && _checkOutTime != null),
                      outerColor: _isCheckedIn ? Colors.red : const Color(0xff008B8B),
                      innerColor: Colors.white,
                      elevation: 4,
                      borderRadius: 12,
                      text: _isCheckedIn ? 'Swipe to Check Out' : 'Swipe to Check In',
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      sliderButtonIcon: Icon(
                        _isCheckedIn ? Icons.horizontal_distribute_rounded : Icons.horizontal_distribute_rounded,
                        color: _isCheckedIn ? Colors.red : const Color(0xff008B8B),
                      ),
                      onSubmit: () {
                        if (!_isCheckedIn) {
                          setState(() {
                            _checkInTime = _now;
                            _attendanceStatus = _getCheckInStatus(_now);
                            _isCheckedIn = true;
                          });
                        } else {
                          setState(() {
                            _checkOutTime = _now;
                            _isCheckedIn = false;
                          });
                        }
                      },
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
