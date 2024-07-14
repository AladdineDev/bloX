import 'package:blox/features/auth/views/signup_screen.dart';
import 'package:blox/features/tweet/views/tweet_post_screen.dart';
import 'package:blox/features/tweet/views/tweet_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blox/features/auth/views/login_screen.dart';
import 'package:blox/features/profil/views/profil_screen.dart';
import 'package:blox/features/webview/views/webview_screen.dart';
import 'package:blox/features/edite_profile/views/edite_profile_screen.dart';

part 'router.g.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal();

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();

  final router = GoRouter(
    routes: $appRoutes,
    initialLocation: '/profile',
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

@TypedGoRoute<EditeProfileScreenRoute>(path: '/edite-profile')
@immutable
class EditeProfileScreenRoute extends GoRouteData{
  @override
  Widget build(BuildContext context, GoRouterState state){
    return  const EditeProfileScreen() ;
  }
}

@TypedGoRoute<LoginScreenRoute>(path: '/login')
@immutable
class LoginScreenRoute extends GoRouteData {
  final LoginStep step;

  const LoginScreenRoute({this.step = LoginStep.login});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginScreen(step: step);
  }
}

@TypedGoRoute<WebviewScreenRoute>(path: '/webview:uri')
@immutable
class WebviewScreenRoute extends GoRouteData {
  final Uri uri;

  const WebviewScreenRoute({required this.uri});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return WebViewScreen(uri: uri);
  }
}

@TypedGoRoute<TweetPostScreenRoute>(path: '/new-tweet')
@immutable
class TweetPostScreenRoute extends GoRouteData {
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
      child: const TweetPostScreen(),
    );
  }
}
