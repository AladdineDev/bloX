import 'package:blox/features/auth/views/login_screen.dart';
import 'package:blox/features/auth/views/signup_screen.dart';
import 'package:blox/features/tweet/views/tweet_list_screen.dart';
import 'package:blox/features/webview/views/webview_screen.dart';
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
