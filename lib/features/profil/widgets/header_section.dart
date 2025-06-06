import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () {
            print('Container clicked');
          },
          child: Container(
            width: double.infinity,
            height: 220,
            color: Colors.blue,
          ),
        ),
        Positioned(
          bottom: -30,
          left: 5,
          child: GestureDetector(
            onTap: () {
              print('Avatar clicked');
            },
            child: const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://wallpapers-clan.com/wp-content/uploads/2023/01/rapper-style-pfp-1.jpg'),
            ),
          ),
        ),
        Positioned(
          bottom: -60,
          right: 10,
          child: Row(
            children: [
              const SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  context.go('/edite');
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(color: Colors.black),
                ),
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