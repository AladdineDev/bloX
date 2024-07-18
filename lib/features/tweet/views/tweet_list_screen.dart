import 'package:blox/core/common/widgets/my_sliver_app_bar.dart';
import 'package:blox/core/common/widgets/my_drawer.dart';
import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/features/tweet/bloc/post_bloc/post_bloc.dart';
import 'package:blox/features/tweet/data_sources/remote_post_data_source.dart';
import 'package:blox/features/tweet/repositories/post_repository.dart';
import 'package:blox/features/tweet/widgets/tweet_list_tab_bar.dart';
import 'package:blox/core/enums/tweet_list_tabs.dart';
import 'package:blox/features/tweet/widgets/tweet_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TweetListScreen extends StatelessWidget {
  const TweetListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepository(
        remoteDataSource: RemotePostDataSource(),
      ),
      child: BlocProvider(
        create: (context) => PostBloc(
          postRepository: context.postRepository,
        )
          ..add(GetForYouPosts())
          ..add(
            GetFollowingPosts(followingIds: []), //TODO: pass user followingIds
          ),
        child: DefaultTabController(
          length: TweetListTabs.values.length,
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
                          tabs: TweetListTabs.values.map((tab) {
                            return tab.title;
                          }).toList(),
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  children: TweetListTabs.values.map((tab) {
                    return Builder(
                      builder: (BuildContext context) {
                        return TweetList(tab: tab);
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
        ),
      ),
    );
  }

  void _onFloationgActionButtonPressed(BuildContext context) {
    TweetPostScreenRoute().push(context);
  }
}
