import 'package:blox/core/common/widgets/my_sliver_app_bar.dart';
import 'package:blox/core/common/widgets/my_drawer.dart';
import 'package:blox/features/tweet/widgets/tweet_list_tab_bar.dart';
import 'package:blox/features/tweet/widgets/tweet_list_tabs.dart';
import 'package:flutter/material.dart';

class TweetListScreen extends StatelessWidget {
  const TweetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TweetListTabs.values.length,
      child: Scaffold(
        drawer: const MyDrawer(),
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                  sliver: SliverPersistentHeader(
                    delegate: MySliverAppBarDelegate(
                      child: MySliverAppBar(
                        bottom: TweetListTabBar(
                          tabs: TweetListTabs.values.map((tab) {
                            return tab.title;
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: TweetListTabs.values.map((tab) {
                return Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(tab.name),
                      physics: const ClampingScrollPhysics(),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context,
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          sliver: SliverList.separated(
                            itemCount: 50,
                            itemBuilder: (context, index) {
                              return Text('${tab.name}: Item $index');
                            },
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                          ),
                        ),
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
