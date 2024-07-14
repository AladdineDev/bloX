import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String name;
  final String handle;
  final String bio;

  const ProfileInfo({
    super.key,
    required this.name,
    required this.handle,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Text(
            name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            handle,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(bio),
          const SizedBox(height: 10),
          _buildFollowInfo(),
        ],
      ),
    );
  }

  Widget _buildFollowInfo() {
    return const Row(
      children:  [
        Text('500 Following', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 10),
        Text('1200 Followers', style: TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}