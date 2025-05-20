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
  final String checkInDevice;  
  final String checkOutDevice; 

  const AttendanceCardComponent({
    Key? key,
    required this.date,
    this.status = 'Present',
    this.checkInTime = '09:45 AM',
    this.checkOutTime = '05:30 PM',
    this.checkInNote = 'Late (+15m)',
    this.checkOutNote = 'Early (-30m)',
    this.totalHours = 'Worked: 8h 28m',
    this.checkInDevice = 'mobile',
    this.checkOutDevice = 'mobile',
  }) : super(key: key);

  Color _statusTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return const Color(0xff1C8300); // Dark Green
      case 'absent':
        return const Color(0xffD10000); // Red
      case 'weekend':
        return const Color(0xffFF8C00); // Orange
      case 'wfh':
        return const Color(0xff8B4513); // Brown
      default:
        return Colors.black;
    }
  }

  Color _statusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'present':
        return const Color(0xffE6FFE6); // Light Green
      case 'absent':
        return const Color(0xffFFE6E6); // Light Red
      case 'weekend':
        return const Color(0xffFFF3E0); // Light Orange
      case 'wfh':
        return const Color(0xffF5E3D8); // Light Brown
      default:
        return Colors.grey.shade200;
    }
  }

  Widget _deviceIcon(String device) {
    switch (device.toLowerCase()) {
      case 'mobile':
        return Container(
          height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: Color(0xff008B8B).withOpacity(0.2),
              borderRadius: BorderRadius.circular(4)
            ),
            child: const Icon(Icons.smartphone_rounded, size: 16, color: Color(0xff008B8B)));
      case 'laptop':
        return const Icon(Icons.laptop, size: 16, color: Color(0xff008B8B));
      default:
        return const SizedBox.shrink();
    }
  }

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
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusBackgroundColor(status),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (status.toLowerCase() == 'weekend') ...[
                        const Icon(Icons.beach_access, size: 14, color: Color(0xffFF8C00)),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 12,
                          color: _statusTextColor(status),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey.shade200),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _deviceIcon(checkInDevice),
                    const SizedBox(width: 6),
                    const Text('Check-In', style: TextStyle(fontSize: 14)),
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
                Row(
                  children: [
                    _deviceIcon(checkOutDevice),
                    const SizedBox(width: 6),
                    const Text('Check-Out', style: TextStyle(fontSize: 14)),
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
