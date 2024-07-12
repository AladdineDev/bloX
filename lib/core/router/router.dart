import 'package:blox/features/auth/views/signup_screen.dart';
import 'package:blox/features/profil/views/profil_screen.dart';
import 'package:blox/features/tweet/views/tweet_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'router.g.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();

  final router = GoRouter(
    routes: $appRoutes,
    initialLocation: '/sign-up',
  );
}

@TypedGoRoute<SignupScreenRoute>(path: '/sign-up')
@immutable
class SignupScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignupScreen();
  }
}

@TypedGoRoute<TweetListScreenRoute>(path: '/tweets')
@immutable
class TweetListScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TweetListScreen();
  }
}

@TypedGoRoute<ProfileScreenRoute>(path: '/profile')
@immutable
class ProfileScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}
