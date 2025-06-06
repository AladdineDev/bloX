import 'package:blox/core/extensions/build_context_extension.dart';
import 'package:blox/core/router/router.dart';
import 'package:blox/core/theme/theme.dart' as theme;
import 'package:blox/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:blox/features/auth/data_sources/remote_auth_data_source.dart';
import 'package:blox/features/auth/repositories/auth_repository.dart';
import 'package:blox/features/profil/bloc/app_user_detail_bloc/app_user_bloc.dart';
import 'package:blox/features/profil/data_sources/remote_app_user_data_source.dart';
import 'package:blox/features/profil/repositories/app_user_repository.dart';
import 'package:blox/features/tweet/bloc/post_bloc/post_bloc.dart';
import 'package:blox/features/tweet/data_sources/remote_post_data_source.dart';
import 'package:blox/features/tweet/repositories/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/profil/bloc/app_user_detail_bloc/app_user_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PostRepository(
            remoteDataSource: RemotePostDataSource(),
          ),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(
            remoteAuthDataSource: RemoteAuthDataSource(),
          ),
        ),
        RepositoryProvider(
          create: (context) => AppUserRepository(
            remoteDataSource: RemoteAppUserDataSource(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostBloc(
              postRepository: context.read<PostRepository>(),
            )
              ..add(GetForYouPosts())
              ..add(GetFollowingPosts(
                  followingIds: [])), //TODO: pass user followingIds
          ),
          BlocProvider(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>())
                  ..add(const AuthGetAppUser()),
          ),
          BlocProvider(
            create: (context) => AppUserBloc(
                appUserRepository: context.read<AppUserRepository>())
              ..add(
                GetOneAppUser(context.read<AuthBloc>().state.appUser!.id!),
              ),
          ),
          BlocProvider(
            create: (context) =>
                AppUserBloc(appUserRepository: context.appUserRepository),
          ),
        ],
        child: Builder(builder: (context) {
          return BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthStatus.authenticated:
                  AppRouter().router.go(TweetListScreenRoute().location);
                  break;
                case AuthStatus.unauthenticated:
                  AppRouter().router.go(OnboardingScreenRoute().location);
                  break;
                default:
              }
            },
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: "BloX",
              routerConfig: AppRouter().router,
              darkTheme: theme.darkTheme,
              themeMode: ThemeMode.dark,
            ),
          );
        }),
      ),
    );
  }
}
