import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarScroller extends StatelessWidget {
  final List<DateTime> days;
  final ScrollController scrollController;

  const CalendarScroller({
    super.key,
    required this.days,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.20,
      left: 0,
      right: 0,
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        controller: scrollController,
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isToday = DateTime.now().day == day.day &&
              DateTime.now().month == day.month &&
              DateTime.now().year == day.year;

          return Container(
            width: MediaQuery.of(context).size.width * 0.22,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: isToday ? const Color(0xff008B8B) : Colors.white,
              border: Border.all(
                color: isToday ? const Color(0xff008B8B) : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  day.day.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isToday ? Colors.white : const Color(0xff008B8B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  DateFormat.E().format(day),
                  style: TextStyle(
                    fontSize: 14,
                    color: isToday ? Colors.white : Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
