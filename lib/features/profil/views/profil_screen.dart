import 'package:flutter/material.dart';

import '../widgets/header_section.dart';
import '../widgets/profile_info.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
             const  SliverToBoxAdapter(
                child: Column(
                  children: [
                    ProfileHeader(),
                    SizedBox(height: 30),
                    ProfileInfo(
                      name: 'AladdineDev',
                      handle: '@voilà',
                      bio: 'blablablabla',
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                 const TabBar(
                    tabs:  [
                      Tab(text: 'About'),
                      Tab(text: 'Tweets'),
                      Tab(text: 'Tweets & reponses'),
                      Tab(text: 'Médias'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: const TabBarView(
            children: [
              Icon(Icons.person_2),
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}