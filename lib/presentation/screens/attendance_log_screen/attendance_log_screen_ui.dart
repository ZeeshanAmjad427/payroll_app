import 'package:dotted_line/dotted_line.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:payroll/core/utils/header_util.dart';
import 'package:payroll/presentation/screens/attendance_log_screen/widgets/attendance_card/attendance_card_component.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/top_left_gradient_color.dart';

import '../home_screen/home_screen_ui/home_screen_ui.dart';
import '../profile_screen/profile_screen_ui.dart';

class AttendanceLogScreenUi extends StatefulWidget {
  const AttendanceLogScreenUi({super.key});

  @override
  State<AttendanceLogScreenUi> createState() => _AttendanceLogScreenUiState();
}

class _AttendanceLogScreenUiState extends State<AttendanceLogScreenUi> {
  int _selectedIndex = 1;

  final List<String> _months = [
    'January 2025',
    'February 2025',
    'March 2025',
    'April 2025',
    'May 2025',
    'June 2025',
    'July 2025',
    'August 2025',
    'September 2025',
    'October 2025',
    'November 2025',
    'December 2025',
  ];

  String _selectedMonth = 'May 2025';
  late List<List<DateTime>> _monthWeeks;
  int _currentWeekIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeMonthWeeks();
  }

  void _initializeMonthWeeks() {
    final selectedDate = DateFormat('MMMM yyyy').parse(_selectedMonth);
    final firstDay = DateTime(selectedDate.year, selectedDate.month, 1);
    final lastDay = DateTime(selectedDate.year, selectedDate.month + 1, 0);

    _monthWeeks = [];
    List<DateTime> currentWeek = [];

    for (DateTime date = firstDay; !date.isAfter(lastDay); date = date.add(const Duration(days: 1))) {
      currentWeek.add(date);
      if (currentWeek.length == 7 || date == lastDay) {
        _monthWeeks.add(List.from(currentWeek));
        currentWeek.clear();
      }
    }

    _currentWeekIndex = 0;
  }

  List<DateTime> get weekDates => _monthWeeks[_currentWeekIndex];

  void _onPrevWeek() {
    setState(() {
      if (_currentWeekIndex > 0) {
        _currentWeekIndex--;
      }
    });
  }

  void _onNextWeek() {
    setState(() {
      if (_currentWeekIndex < _monthWeeks.length - 1) {
        _currentWeekIndex++;
      }
    });
  }

  void _onMonthChanged(String? newMonth) {
    if (newMonth == null) return;
    setState(() {
      _selectedMonth = newMonth;
      _initializeMonthWeeks();
    });
  }

  String getWeekText(int index) {
    const weekNames = [
      "First Week",
      "Second Week",
      "Third Week",
      "Fourth Week",
      "Fifth Week",
      "Sixth Week"
    ];
    return index < weekNames.length ? weekNames[index] : "${index + 1}th Week";
  }

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
        Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceLogScreenUi()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String weekText = getWeekText(_currentWeekIndex);
    String weekInfoText = 'Week ${_currentWeekIndex + 1} of ${_monthWeeks.length}';

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: TopLeftGradientPainter(),
            child: Container(),
          ),
          HeaderUtil(title: "My Attendance"),
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

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              'Attendance Log',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                             SizedBox(height: 4.h),
                            Text(
                              weekText,
                              style:  TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff008B8B),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding:  EdgeInsets.symmetric(horizontal: 12.w),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint:  Text(
                                'Select Month',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              items: _months.map((month) {
                                return DropdownMenuItem<String>(
                                  value: month,
                                  child: Text(
                                    month,
                                    style:  TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: _selectedMonth,
                              onChanged: _onMonthChanged,
                              buttonStyleData:  ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 0.w),
                                height: 40.h,
                                width: 140.w,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200.h, // dropdown won't fully open and will scroll
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: Colors.white,
                                ),
                              ),
                              menuItemStyleData:  MenuItemStyleData(
                                height: 40.h,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                     SizedBox(height: 10),
                    Padding(
                      padding:  EdgeInsets.only(right: 8.w,left: 8.w),
                      child: DottedLine(
                        dashLength: 3.0,
                        dashGapLength: 5.0,
                        lineThickness: 1.0,
                        dashColor: Colors.grey.withOpacity(0.4),
                      ),
                    ),
                     SizedBox(height: 10.h),

                    // Attendance cards for the week
                    for (var date in weekDates)
                      if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday)
                        AttendanceCardComponent(
                          date: date,
                          status: "Weekend",
                          checkInTime: "00:00",
                          checkOutTime: "00:00",
                          checkInNote: "",
                          checkOutNote: "",
                          totalHours: "00:00",
                        )
                      else
                        AttendanceCardComponent(date: date),

                    Padding(
                      padding:  EdgeInsets.all(8.0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            weekInfoText,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: _onPrevWeek,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  padding:  EdgeInsets.symmetric(horizontal: 12.w),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: const Text(
                                  'Prev Week',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                               SizedBox(width: 8.w),
                              ElevatedButton(
                                onPressed: _onNextWeek,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding:  EdgeInsets.symmetric(horizontal: 12.w),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: const Text(
                                  'Next Week',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ],
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
  }
}
