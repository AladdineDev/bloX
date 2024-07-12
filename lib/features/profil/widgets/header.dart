import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          height: 220,
          color: Colors.blue,
        ),
       const  Positioned(
          bottom: -30,
          left: 5,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://wallpapers-clan.com/wp-content/uploads/2023/01/rapper-style-pfp-1.jpg'),
          ),
        ),
      ],
    );
  }
}