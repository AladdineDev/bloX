import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/core/theme/theme.dart' as theme;
import 'package:blox/features/tweet/bloc/post_bloc/post_bloc.dart';
import 'package:blox/features/tweet/data_sources/remote_post_data_source.dart';
import 'package:blox/features/tweet/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          ..add(GetFollowingPosts(
              followingIds: [])), //TODO: pass user followingIds
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "BloX",
          routerConfig: AppRouter().router,
          darkTheme: theme.darkTheme,
          themeMode: ThemeMode.dark,
        ),
      ),
    );
  }
}
