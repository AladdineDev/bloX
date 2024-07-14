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
        const Positioned(
          bottom: -30,
          left: 5,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://wallpapers-clan.com/wp-content/uploads/2023/01/rapper-style-pfp-1.jpg'),
          ),
        ),
        Positioned(
          bottom: -60,
          right: 10,
          child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print("bloc Message ");
                },
                child: const  Icon(Icons.mail_outline_sharp, color: Colors.black),
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  print("bloc Follow ");
                },
                child: const Text('Follow', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}