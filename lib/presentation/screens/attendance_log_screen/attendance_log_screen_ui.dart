import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll/presentation/screens/attendance_log_screen/widgets/attendance_card/attendance_card_component.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/widgets/top_left_gradient_color.dart';
import 'package:intl/intl.dart';

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

  List<DateTime> weekDates = [];

  /// Stores the Monday date of the current shown week
  late DateTime _currentMonday;

  @override
  void initState() {
    super.initState();
    _initializeCurrentMonday();
    _updateWeekDates();
  }

  void _initializeCurrentMonday() {
    DateTime selectedMonthDate = DateFormat('MMMM yyyy').parse(_selectedMonth);
    DateTime today = DateTime.now();

    if (today.year == selectedMonthDate.year && today.month == selectedMonthDate.month) {
      _currentMonday = today.subtract(Duration(days: today.weekday - DateTime.monday));
    } else {
      DateTime firstOfMonth = DateTime(selectedMonthDate.year, selectedMonthDate.month, 1);
      int offset = DateTime.monday - firstOfMonth.weekday;
      if (offset < 0) offset += 7;
      _currentMonday = firstOfMonth.add(Duration(days: offset));
    }
  }

  void _updateWeekDates() {
    weekDates.clear();
    for (int i = 0; i < 7; i++) {
      weekDates.add(_currentMonday.add(Duration(days: i)));
    }
  }

  int getCurrentWeekOfMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final offset = firstDayOfMonth.weekday - 1;
    return ((date.day + offset - 1) ~/ 7) + 1;
  }

  int getTotalWeeksInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday;
    final totalDays = lastDayOfMonth.day;
    final totalWeeks = ((totalDays + (firstWeekday - 1)) / 7).ceil();
    return totalWeeks;
  }

  String getWeekText(int weekNumber) {
    switch (weekNumber) {
      case 1:
        return "First Week";
      case 2:
        return "Second Week";
      case 3:
        return "Third Week";
      case 4:
        return "Fourth Week";
      default:
        return "${weekNumber}th Week";
    }
  }

  void _onPrevWeek() {
    setState(() {
      _currentMonday = _currentMonday.subtract(const Duration(days: 7));
      DateTime selectedMonthDate = DateFormat('MMMM yyyy').parse(_selectedMonth);
      if (_currentMonday.month < selectedMonthDate.month || _currentMonday.year < selectedMonthDate.year) {
        DateTime firstOfMonth = DateTime(selectedMonthDate.year, selectedMonthDate.month, 1);
        int offset = DateTime.monday - firstOfMonth.weekday;
        if (offset < 0) offset += 7;
        _currentMonday = firstOfMonth.add(Duration(days: offset));
      }
      _updateWeekDates();
    });
  }

  void _onNextWeek() {
    setState(() {
      _currentMonday = _currentMonday.add(const Duration(days: 7));
      DateTime selectedMonthDate = DateFormat('MMMM yyyy').parse(_selectedMonth);
      final lastDayOfMonth = DateTime(selectedMonthDate.year, selectedMonthDate.month + 1, 0);
      if (_currentMonday.month > selectedMonthDate.month || _currentMonday.year > selectedMonthDate.year) {
        int offset = lastDayOfMonth.weekday - DateTime.monday;
        if (offset < 0) offset += 7;
        _currentMonday = lastDayOfMonth.subtract(Duration(days: offset));
      }
      _updateWeekDates();
    });
  }

  void _onMonthChanged(String? newMonth) {
    if (newMonth == null) return;
    setState(() {
      _selectedMonth = newMonth;
      _initializeCurrentMonday();
      _updateWeekDates();
    });
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
    DateTime selectedMonthDate = DateFormat('MMMM yyyy').parse(_selectedMonth);
    int totalWeeksInMonth = getTotalWeeksInMonth(selectedMonthDate);
    int currentWeekNumber = getCurrentWeekOfMonth(_currentMonday);
    String weekText = getWeekText(currentWeekNumber);
    String weekInfoText = 'Week $currentWeekNumber of $totalWeeksInMonth';

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
            right: 20,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
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
                        'My Attendance',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row with "Attendance Log", week text below it, and dropdown at right
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Attendance Log',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              weekText,
                              style: const TextStyle(
                                fontSize: 14,
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
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedMonth,
                                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                items: _months.map((month) {
                                  return DropdownMenuItem<String>(
                                    value: month,
                                    child: Text(month),
                                  );
                                }).toList(),
                                onChanged: _onMonthChanged,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),

                    // Show attendance cards
                    for (var date in weekDates)
                      if (date.weekday == DateTime.saturday || date.weekday == DateTime.sunday)
                      // Weekend card with status "Weekend" and 00:00 times
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
                      // Weekday card as normal
                        AttendanceCardComponent(date: date),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            weekInfoText,
                            style: TextStyle(
                              fontSize: 14,
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
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Prev Week',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: _onNextWeek,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade200,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
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
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
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
