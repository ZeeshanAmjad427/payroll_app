import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceCardComponent extends StatelessWidget {
  final DateTime date;
  final String status;
  final String checkInTime;
  final String checkOutTime;
  final String checkInNote;
  final String checkOutNote;
  final String totalHours;

  const AttendanceCardComponent({
    Key? key,
    required this.date,
    this.status = 'Present',
    this.checkInTime = '09:45 AM',
    this.checkOutTime = '05:30 PM',
    this.checkInNote = 'Late (+15m)',
    this.checkOutNote = 'Early (-30m)',
    this.totalHours = 'Worked: 8h 28m',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shadowColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: const Color(0xff008B8B).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.calendar_today,
                      size: 20, color: Color(0xff008B8B)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    DateFormat('MMM dd, yyyy').format(date),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xff4DFF00).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff1C8300),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 8),
                    Text('Check-In', style: TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        checkInNote,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(checkInTime, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 8),
                    Text('Check-Out', style: TextStyle(fontSize: 14)),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xff008B8B).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        checkOutNote,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff008B8B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(checkOutTime, style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    SizedBox(width: 8),
                    Text('Total Working Hours', style: TextStyle(fontSize: 14)),
                  ],
                ),
                Text(
                  totalHours,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff008B8B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
