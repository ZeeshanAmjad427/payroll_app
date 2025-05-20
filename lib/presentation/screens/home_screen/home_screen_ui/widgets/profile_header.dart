import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.1,
      left: 20,
      right: 20,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff008B8B),
                width: 3,
              ),
            ),
            child: const CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/profile.jpg'),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mustafa Tayabani',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Sr. UI/UX Designer',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            height: 35,
              width: 35,
              decoration: BoxDecoration(
              shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(4),
    color: const Color(0xff008B8B).withOpacity(0.2),
    ),
              child: Icon(Icons.search,size: 32,color: Color(0xff008B8B),))
        ],
      ),
    );
  }
}
