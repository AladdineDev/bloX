import 'package:blox/features/tweet/widgets/tweet_list.dart';
import 'package:blox/core/enums/tweet_list_tabs.dart'; // Import the TweetListTab enum
import 'package:flutter/material.dart';
import '../../tweet/widgets/tweet_list_profile.dart';
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
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    ProfileHeader(),
                    const SizedBox(height: 30),
                    const ProfileInfo(),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    tabs: [
                      Tab(text: 'Tweets'),
                      Tab(text: 'Tweets & responses'),
                      Tab(text: 'Médias'),
                      Tab(text: 'Likes'),
                    ],
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              TweetListProfile(tweetListTab: TweetListTab.post),
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
