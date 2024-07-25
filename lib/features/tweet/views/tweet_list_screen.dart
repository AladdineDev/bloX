import 'package:blox/core/common/widgets/my_sliver_app_bar.dart';
import 'package:blox/core/common/widgets/my_drawer.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/profil/bloc/app_user_detail_bloc/app_user_bloc.dart';
import 'package:blox/features/tweet/widgets/tweet_list_tab_bar.dart';
import 'package:blox/core/enums/tweet_list_tabs.dart';
import 'package:blox/features/tweet/widgets/tweet_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetListScreen extends StatefulWidget {
  const TweetListScreen({super.key});

  @override
  State<TweetListScreen> createState() => _TweetListScreenState();
}

class _TweetListScreenState extends State<TweetListScreen> {
  static const _tweetListTabs = [
    TweetListTab.forYou,
    TweetListTab.following,
  ];
  final _scrollController = ScrollController();

  @override
  void initState() {
    context.appUserBloc.add(
      GetOneAppUser(
        context.authBloc.state.appUser!.id!,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tweetListTabs.length,
      child: Scaffold(
        drawer: const MyDrawer(),
        body: SafeArea(
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                    context,
                  ),
                  sliver: MySliverAppBar(
                    bottom: TweetListTabBar(
                      tabs: _tweetListTabs.map((tab) {
                        return Text(tab.title);
                      }).toList(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: _tweetListTabs.map((tab) {
                return Builder(
                  builder: (BuildContext context) {
                    return Scrollbar(
                      controller: _scrollController,
                      child: CustomScrollView(
                        controller: _scrollController,
                        key: PageStorageKey<String>(tab.name),
                        physics: const ClampingScrollPhysics(),
                        slivers: <Widget>[
                          SliverOverlapInjector(
                            handle:
                                NestedScrollView.sliverOverlapAbsorberHandleFor(
                              context,
                            ),
                          ),
                          TweetList(tweetListTab: tab),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _onFloationgActionButtonPressed(context),
          child: const Icon(
            Icons.edit_outlined,
          ),
        ),
      ),
    );
  }

  void _onFloationgActionButtonPressed(BuildContext context) {
    const TweetPostScreenRoute().push(context);
  }
}
