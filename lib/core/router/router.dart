import 'package:blox/features/auth/views/signup_screen.dart';
import 'package:blox/features/tweet/views/tweet_creation_screen.dart';
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

@TypedGoRoute<TweetListScreenRoute>(path: '/tweets')
@immutable
class TweetListScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TweetListScreen();
  }
}

@TypedGoRoute<SignupScreenRoute>(path: '/sign-up')
@immutable
class SignupScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignupScreen();
  }
}

@TypedGoRoute<TweetCreationScreenRoute>(path: '/new-tweet')
@immutable
class TweetCreationScreenRoute extends GoRouteData {
  @override
  CustomTransitionPage buildPage(BuildContext context, GoRouterState state) {
    return CustomTransitionPage(
      key: state.pageKey,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        var curve = Curves.easeOut;
        var curveTween = CurveTween(curve: curve);
        final tween = Tween(begin: begin, end: end).chain(curveTween);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      child: const TweetCreationScreen(),
    );
  }
}
