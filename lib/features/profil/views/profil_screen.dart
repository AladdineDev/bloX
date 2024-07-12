import 'package:flutter/material.dart';

import '../widgets/header.dart';
import '../widgets/profile_info.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            ProfileHeader(),
            SizedBox(height: 30),
            ProfileInfo(name: 'AladdineDev', handle: '@voilà', bio: 'blablablabla'),
            TabBar(
              tabs: [
                Tab(text: 'About'),
                Tab(text: 'Tweets'),
                Tab(text: 'Tweets & reponses'),
                Tab(text: 'Médias'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Icon(Icons.person_2),
                  Icon(Icons.directions_car),
                  Icon(Icons.directions_transit),
                  Icon(Icons.directions_bike),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}